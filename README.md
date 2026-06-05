# Cartografía Estelar de Exoplanetas: Inferencia y Visualización en MATLAB
## DESCRIPCIÓN DEL PROYECTO  
Este proyecto aplica técnicas de procesamiento de datos, clasificación estadística y visualización científica para analizar un conjunto de estrellas de la base de datos NASA Exoplanet Archive. A partir de parámetros físicos como masa, metalicidad, luminosidad, amplitud radial y actividad cromosférica, se desarrolla un sistema de inferencia de presencia planetas dividido en dos partes:

1. Clasificación binaria: Predicción de la presencia o ausencia de planetas mediante métodos estadísticos y de aprendizaje supervisado (regresión logística, árboles de decisión, SVM).
2. Regresión: Estimación del número potencial de planetas asociados a cada estrella utilizando modelos de regresión lineal, polinómica y ensambles como Random Forest.

Posteriormente, se realiza un estudio de los tipos espectrales de estrellas, explorando la relación entre clase estelar y probabilidad de albergar sistemas planetarios. Además, se construyen diagramas de Hertzsprung-Russell (HR), tanto generales como filtrados para estrellas con planetas, con el fin de identificar las regiones del diagrama donde se concentran los sistemas planetarios con mayor frecuencia.

El proyecto se implementa en Matlab, e integra importación y limpieza de datos, funciones modulares, visualizaciones 2D y 3D, clustering estadístico y dashboards interactivos. Por último, se realiza una reflexión crítica sobre el uso de herramientas de IA generativa (MATLAB Copilot) en el proceso de desarrollo.

## JUSTIFICACIÓN
El estudio de exoplanetas constituye uno de los campos más dinámicos de la astrofísica moderna, ya que permite comprender la formación y evolución de sistemas planetarios fuera del Sistema Solar. Sin embargo, la gran cantidad de datos disponibles en archivos astronómicos requiere herramientas computacionales que faciliten su análisis y visualización.

Este proyecto se justifica en la necesidad de aplicar técnicas de programación científica en MATLAB para integrar distintos enfoques:

Clasificación binaria, que permite identificar qué estrellas tienen mayor probabilidad de albergar planetas.

Regresión, que estima el número aproximado de planetas asociados a cada estrella.

Análisis espectral y visualización HR, que relaciona los tipos de estrellas con la presencia de planetas y muestra su distribución en el diagrama Hertzsprung-Russell.

La combinación de estos métodos ofrece una visión más completa y robusta del fenómeno, conectando estadística, aprendizaje automático y visualización científica. Además, fortalece competencias en programación, análisis de datos y modelado, alineadas con los objetivos formativos de la ingeniería mecatrónica.

## DESARROLLO: SECCIONES DEL PROYECTO
### Estructura del proyecto
Este proyecto se encuentra en una carpeta llamada `ProyectoFinal`. Dentro de ella, están los siguientes archivos:
1. `funcion_principal.m`: Esta función es el "main" del proyecto, en ella se llaman todas las funciones secundarias para que corran en el orden en el que se desean obtener los resultados; presenta la estructura general del proyecto y realiza los análisis comparativos entre los modelos implementados en el proyecto.  
2. `cargar_datos.m`: Función para realizar la carga de datos del archivo `datos_estrellas.xlsx` a dos matrices en Matlab, con las cuales se realizaría el posterior procesamiento de datos.  
3. `clasificacion_binaria.m`: Función en la que se aplican los 4 métodos de clasificación binaria con los cuales se determinaría si una estrella tiene o no planeta(s).  
4. `regresion_planetas.m`: Función en la que se aplican los 4 métodos de regresión con los cuales se determinaría la cantidad de planetas aproximada que tiene cada estrella.
5. `analisis_tipos.m`: 
6. `graficar_HR.m`:
7. `datos_estrellas.xlsx`: Archivo de Excel con la base de datos completa descargada.

Archivos complementarios: 
1. `script_resultante.pdf`: El script generado por Matlab al correr el código completo, con los displays de una muestra de los resultados obtenidos en cada función y las gráficas.

### 1. Carga de datos
En la primera sección, denominada carga de datos, se implementó la función `cargar_datos.m` para subir el archivo de Excel que contiene la totalidad de los datos descargados de la base de datos NASA Exoplanet Archive [1] (la cual se encuentra en referencias), de manera que se crearan dos matrices:  
1. `T`: La matriz que contiene todos los datos que serían utilizados para los posteriores análisis y regresiones.  
   'Hostname','StMass','StMet','StLum','StTeff','StSpectype','SyVmag','SyBvmag','SyPlanetsFlag','SyPnum'  
2. `MatrizValidacion`: La matriz que contiene únicamente 3 columnas, con las cuales se hará la validación de la precisión de los datos obtenidos con las clasificaciones y regresiones implementadas.  
   'Hostname', 'SyPlanetsFlag', 'SyPnum'  

### 2. Clasificación binaria  
En esta sección se aplicaron y compararon 4 métodos distintos para predecir de forma binaria si una estrella tiene o no planetas orbitantes, de manera que obtener un 1 representara para cada estrella la presencia de uno o más planetas orbitantes, y obtener un 0 representara la ausencia de planetas orbitando esa estrella.  
Posteriormente, se realizó una comparación con los datos de "Planets Flag" de la base de datos.  

1. Regresión logística - `fitglm`  
   Es un modelo estadístico que estima la probabilidad de que ocurra un evento binario en el que 1 es sí y 0 es no.  
   **Funcionamiento:**  
   Usa una función logística (sigmoide) para transformar una combinación lineal de variables predictoras en una probabilidad entre 0 y 1. Si la probabilidad es mayor a un umbral (0.5), clasifica como “1” (estrella con planetas), si no, clasifica como "0" (estrella sin planetas).  
   **Función** `fitglm` **:**  
   fitglm corresponde a la abreviación de Fit Generalized Linear Model.  
   Esta función ajusta un modelo lineal generalizado, calculando la probabilidad de que la respuesta sea 1 en función de las variables predictorias.  
   En este caso, haciendo uso de 'Distribution' y 'binomial' este modelo lineal se convierte en una regresión logística, cuya salida es un objeto modelo (variable `mdl_log`) que tiene coeficientes, estadísticas y un método predict para estimar probabilidades.  

   **Variables utilizadas en el modelo:** Al consultar fuentes teóricas citadas a continuación, se encontró que que las variables que mayor influencia tienen en la formación de planetas son la masa estelar, la metalicidad y la luminosidad.  
    - **Masa estelar:** La ocurrencia de planetas gigantes aumenta con la *masa estelar*, pasando aproximadamente de 3.5% para estrellas de baja masa a 14% para estrellas de mayor masa. [2]  
    - **Metalicidad:** Fischer y Valenti demostraron que las estrellas ricas en metales presentan una probabilidad mucho mayor de albergar planetas gigantes. Este resultado ha sido confirmado repetidamente. [3]  
    - **Luminosidad:** La luminosidad también afecta la estructura térmica del disco protoplanetario y las condiciones bajo las cuales se forman los planetas. [4]  

2. Árbol de decisión - `fitctree`  
   Es un modelo que divide los datos en ramas según reglas simples.  
   **Funcionamiento:**  
   Construye un árbol donde cada nodo representa una condición sobre una variable, las hojas del árbol representan la clasificación final (planetas sí/no).  
   **Función** `fitctree` **:**  
   fitctree corresponde a la abreviación de Fit Classification Tree.  
   Esta función entrena un árbol de decisión para clasificación, dividiendo los datos en ramas según condiciones sobre las variables predictoras, hasta llegar a hojas que representan la clase final.  
   En este caso, la salida de la función es un objeto árbol (variable `mdl_tree`) que se puede visualizar con  
   ``` Matlab
   view(mdl_tree,'Mode','graph')
   ```

3. k-Nearest Neighbors (KNN) - `fitcknn`  
   Es un modelo basado en la similitud entre observaciones.  
   **Funcionamiento:**  
   Para clasificar una estrella, busca las k estrellas más cercanas en el espacio de variables predictoras, y clasifica según la mayoría de esas vecinas (ejemplo: si 4 de 5 vecinas tienen planetas, se predice “con planetas”).  
   **Función** `fitcknn` **:**  
   fitcknn corresponde a la abreviación de Fit Classification k-Nearest Neighbors.  
   Esta función entrena un modelo de vecinos más cercanos; para clasificar un punto nuevo, busca los k puntos más cercanos en el conjunto de entrenamiento y asigna la clase mayoritaria.  
   En este caso, la salida de la función es un objeto KNN (variable `mdl_knn`) que usa predict para clasificar nuevos datos.  

4. Support Vector Machines (SVM) - `fitcsvm`  
   Es un modelo que busca el “mejor hiperplano” que separa las dos clases.  
   **Funcionamiento:**  
   Encuentra una frontera que maximiza la distancia entre las clases (estrella con planetas vs. sin planetas). A continuación, haciendo uso de kernels maneja separaciones no lineales.  
   **Función** `fitcsvm` **:**  
   fitcsvm corresponde a la abreviación de Fit Classification Support Vector Machine.  
   Esta función entrena un SVM para clasificación binaria; encuentra el hiperplano que mejor separa las dos clases, y con `KernelFunction`,`rbf`, permite separar datos no lineales usando un kernel radial.  
   En este caso, la salida de la función es un objeto SVM (variable `mdl_svm`) que clasifica nuevos datos con predict.  

**RETORNO DE LA FUNCIÓN:** En la función se retorna resultados, una estructura que contiene cada modelo entrenado (objeto que guarda parámetros, coeficientes, etc.) en `T` y las predicciones que ese modelo hizo sobre los datos de entrada en `y`, la cual se calcula como un valor de precisión entre 0 y 1.  
``` Matlab
resultados = clasificacion_binaria(T, y);
```

### 3. Regresión: cantidad estimada de planetas  

1. Regresión lineal múltiple - `fitlm`  
   Este método ajusta una relación lineal entre las variables predictoras (ej. masa, metalicidad, luminosidad) y la variable respuesta (número de planetas).  
   **Función** `fitlm` **:**
   fitlm corresponde a la abreviación de Fit Linear Model.  
   Esta función ajusta un modelo de regresión lineal múltiple, y se utiliza para relacionar una variable numérica con varias variables predictoras.  
   En este caso, la salida de la función es un objeto de tipo LinearModel que contiene los coeficientes, estadísticas y permite hacer predicciones con predict.  

2. Regresión polinómica  
   Extiende la regresión lineal agregando términos polinómicos para capturar relaciones no lineales, se lleva a cabo porque las estrellas más    masivas tienden a tener más planetas hasta cierto límite.  

3. Random Forest Regressor - `TreeBagger`  
   Este método entrena muchos árboles de decisión y promedia sus predicciónes, capturando relaciones complejas para reducir el sobreajuste de un solo árbol.  
   **Función** `TreeBagger` **:**  
   Esta función entrena un conjunto de árboles de decisión (bosque aleatorio) y promedia sus resultados para regresión, capturando así relaciones complejas y no lineales entre las variables predictoras y la respuesta.  
   En este caso, la salida de la función es un objeto TreeBagger que guarda todos los árboles y permite hacer predicciones con predict.  

4. Redes neuronales - `fitnet`  
   Este método es el modelo más avanzado que puede aprender patrones no lineales complejos. Se entrena con capas ocultas y neuronas, por lo cual al implementarlo se demostrará si la cantidad de datos de la base de datos es suficiente, con base en la precisión que tenga al detectar la cantidad de planetas que tiene cada estrella al realizar la comparación con los valores de la base de datos.  
   **Función** `fitnet` **:**  
   fitnet corresponde a la abreviación de Fit Neural Network.  
   Esta función entrena una red neuronal feedforward para regresión o clasificación, modelando relaciones no lineales complejas entre las variables predictoras y la respuesta.  
   En este caso, la salida de la función es un objeto network que contiene la arquitectura de la red (capas, neuronas, pesos) y permite hacer predicciones con net(X).  

**RETORNO DE LA FUNCIÓN:**
El RMSE (Root Mean Squared Error) es una métrica estándar para evaluar modelos de regresión.

Mide el promedio del error cuadrático entre lo real y lo predicho.

Al tomar la raíz cuadrada, se expresa en las mismas unidades que la variable objetivo (en este caso, número de planetas).

Un RMSE más bajo significa que el modelo predice más cerca de los valores reales.

Ventaja:

Penaliza más los errores grandes (porque se elevan al cuadrado).

Es intuitivo: si el RMSE = 1.2, significa que en promedio el modelo se equivoca por ~1.2 planetas.

📌 ¿Por qué se compara con RMSE?
El RMSE (Root Mean Squared Error) mide el error promedio entre los valores reales y los predichos.

Se expresa en las mismas unidades que la variable objetivo (en este caso, número de planetas).

Penaliza más los errores grandes, lo que lo hace una métrica sensible y confiable para comparar modelos de regresión.

El modelo con menor RMSE es el que mejor aproxima la cantidad de planetas.


## RESULTADOS

### 1. Carga de datos

``` Matlab
       NombreEstrella       PlanetasFlag    NumPlanetas
    ____________________    ____________    ___________

    "3 Ursae Majoris A"        {'N'}             0     
    "HD 78366"                 {'N'}             0     
    "13 Ursae Majoris A"       {'N'}             0     
    "HD 84737"                 {'N'}             0     
    "36 Ursae Majoris A"       {'N'}             0     
    "HD 91324"                 {'N'}             0     
    "Groombridge 1830"         {'N'}             0     
    "Eta Corvi"                {'N'}             0     
    "Chara"                    {'N'}             0     
    "HD 114613"                {'Y'}             1
```

### 2. Clasificación binaria

``` Matlab
Comparación de precisión entre modelos:
            Modelo             Precisión
    _______________________    ________

    {'Regresión Logística'}    0.79878 
    {'Árbol de Decisión'  }    0.89024 
    {'KNN'                }    0.79878 
    {'SVM'                }    0.81707
```

### Regresión: Cantidad estimada de planetas

``` Matlab
Comparación de RMSE entre modelos de regresión:
         Modelo           RMSE  
    _________________    _______

    {'Lineal'       }      1.012
    {'Polinómica'   }     1.0093
    {'Random Forest'}    0.81631
    {'Red Neuronal' }     1.0594
```

## REFLEXIÓN SOBRE IA
### Implementación de la IA en el proyecto

### Prompts utilizados con Copilot


## CONCLUSIONES
Integración de métodos computacionales: El proyecto logró combinar técnicas de clasificación, regresión y análisis espectral en MATLAB, lo que permitió abordar el problema de la inferencia de exoplanetas desde diferentes perspectivas complementarias.

Clasificación binaria: Se implementaron cuatro modelos (Regresión Logística, Árbol de Decisión, KNN y SVM) para identificar estrellas con planetas. La comparación de métricas mostró que algunos métodos ofrecen mayor precisión, evidenciando la importancia de evaluar distintos enfoques antes de seleccionar el más adecuado.

Regresión para estimación de planetas: El uso de modelos lineales, polinómicos, Random Forest y redes neuronales permitió aproximar el número de planetas por estrella. La comparación mediante RMSE demostró que los modelos no lineales capturan mejor las relaciones complejas entre las variables estelares y la cantidad de planetas.

Análisis por tipo espectral: Se evidenció que ciertos tipos de estrellas presentan mayor proporción de planetas, y el diagrama HR filtrado mostró tendencias claras en la distribución de estrellas con planetas, reforzando la conexión entre clasificación, regresión y análisis espectral.

Visualización científica: Los diagramas HR y los gráficos comparativos facilitaron la interpretación de los resultados, mostrando patrones que no serían evidentes únicamente con valores numéricos.

Valor académico y científico: El proyecto no solo fortaleció competencias en programación y análisis de datos, sino que también aportó una visión más sólida sobre cómo la computación aplicada puede apoyar la investigación astronómica, integrando estadística, aprendizaje automático y visualización.

## REFERENCIAS
**BASE DE DATOS:**  
[1] NASA Exoplanet Archive, “Directly Imaged Stars and Exoplanets (DI_STARS_EXEP),” California Institute of Technology, Pasadena, CA, USA. [Online]. Available: https://exoplanetarchive.ipac.caltech.edu/cgi-bin/TblView/nph-tblView?app=ExoTbls&config=DI_STARS_EXEP. [Accessed: 04-Jun-2026]. :contentReference[oaicite:0]{index=0}  

[2] J. A. Johnson, K. M. Aller, A. W. Howard, and J. R. Crepp, “Giant Planet Occurrence in the Stellar Mass-Metallicity Plane,” Publications of the Astronomical Society of the Pacific, vol. 122, no. 894, pp. 905–915, Aug. 2010, doi: 10.1086/655775. :contentReference[oaicite:1]{index=1}  

[3] D. A. Fischer and J. Valenti, “The Planet-Metallicity Correlation,” The Astrophysical Journal, vol. 622, no. 2, pp. 1102–1117, Apr. 2005, doi: 10.1086/428383. :contentReference[oaicite:2]{index=2}  

[4] W. Dunham, “Planet-forming disk around small star offers big surprises,” Reuters, Jun. 06, 2024. [Online]. Available: https://www.reuters.com/science/planet-forming-disk-around-small-star-offers-big-surprises-2024-06-06/. [Accessed: 04-Jun-2026].  

## AUTORA
Valeria Andrea Parra García - valeriaparrag@javeriana.edu.co
