# Cartografía Estelar de Exoplanetas: Inferencia y Visualización en MATLAB
## DESCRIPCIÓN DEL PROYECTO  
Este proyecto aplica técnicas de procesamiento de datos, clasificación estadística y visualización científica para analizar un conjunto de estrellas de la base de datos NASA Exoplanet Archive. A partir de parámetros físicos como masa, metalicidad, luminosidad, amplitud radial y actividad cromosférica, se desarrolla un sistema de inferencia de presencia planetas dividido en dos partes:  

1. Clasificación binaria: Predicción de la presencia o ausencia de planetas mediante métodos estadísticos y de aprendizaje supervisado (regresión logística, árboles de decisión, SVM, KNN).  
2. Regresión: Estimación del número potencial de planetas asociados a cada estrella utilizando modelos de regresión lineal, polinómica y ensambles como Random Forest.  

Posteriormente, se realiza un estudio de los tipos espectrales de estrellas, explorando la relación entre clase estelar y probabilidad de albergar sistemas planetarios. Además, se construyen diagramas de Hertzsprung-Russell (HR), tanto generales como filtrados para estrellas con planetas, con el fin de identificar las regiones del diagrama donde se concentran los sistemas planetarios con mayor frecuencia.  

El proyecto se implementa en Matlab, e integra importación y limpieza de datos, funciones modulares, visualizaciones 2D y 3D, clustering estadístico y dashboards interactivos. Por último, se realiza una reflexión crítica sobre el uso de herramientas de IA generativa (Matlab Copilot) en el proceso de desarrollo.  

## JUSTIFICACIÓN
El estudio de exoplanetas constituye uno de los campos más importantes de la astrofísica moderna, ya que permite comprender la formación y evolución de sistemas planetarios fuera del Sistema Solar, al encontrar patrones de comportamiento en común entre los sistemas planetarios.

Este proyecto pretende integrar distintos enfoques que puede tener el estudio de sistemas planetarios, haciendo uso de programación en Matlab. Al combinar los enfoques de clasificación binaria, regresiones, análisis espectrales y visualización en diagramas, permite comprender claramente las características de las estrellas que posibilitan que se dé este fenómeno, al mezclar la estadística con el aprendizaje automático y la visualización científica. Así mismo, el enfoque de este proyecto abre la posibilidad de comprender cuáles son los modelos de análisis y procesamiento de datos más efectivos y precisos para estimar la presencia de planetas orbitando una estrella y su cantidad.  

Por último, más allá de la temática del proyecto, al desarrollarlo se fortalecen competencias en programación, análisis de datos y modelado, alineadas con los objetivos formativos de la ingeniería mecatrónica.  

## DESARROLLO: SECCIONES DEL PROYECTO
### Estructura del proyecto
Este proyecto se encuentra en una carpeta llamada `ProyectoFinal`. Dentro de ella, están los siguientes archivos:  
1. `funcion_principal.m`: Esta función es el "main" del proyecto, en ella se llaman todas las funciones secundarias para que corran en el orden en el que se desean obtener los resultados; presenta la estructura general del proyecto y realiza los análisis comparativos entre los modelos implementados en el proyecto.  
2. `cargar_datos.m`: Función para realizar la carga de datos del archivo `datos_estrellas.xlsx` a dos matrices en Matlab, con las cuales se realizaría el posterior procesamiento de datos.  
3. `clasificacion_binaria.m`: Función en la que se aplican los 4 métodos de clasificación binaria con los cuales se determinaría si una estrella tiene o no planeta(s).  
4. `regresion_planetas.m`: Función en la que se aplican los 4 métodos de regresión con los cuales se determinaría la cantidad de planetas aproximada que tiene cada estrella.  
5. `analisis_tipos.m`: Función en la que se realiza un análisis de datos generando gráficos de barras, diagramas H&R y analizando clusters en diagramas.  
6. `graficar_HR.m`: Función que filtra las estrellas con planetas y las grafica en el diagrama Hertzsprung-Russell.  
7. `datos_estrellas.xlsx`: Archivo de Excel con la base de datos completa descargada.  

**Archivos complementarios:**
1. `script_resultante.pdf`: El script generado por Matlab al correr el código completo, con los displays de una muestra de los resultados obtenidos en cada función y las gráficas.
2. `prompts_Copilot.txt`: Un archivo de texto que contiene los prompts que se utilizaron en la inteligencia artificial Copilot para resolver problemas presentados en el desarrollo del proyecto.

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


**RETORNO DE LA FUNCIÓN:** En la función `clasificacion_binaria` se retorna resultados, una estructura que contiene cada modelo entrenado (objeto que guarda parámetros, coeficientes, etc.) en `T` y las predicciones que ese modelo hizo sobre los datos de entrada en `y`, la cual se calcula como un valor de precisión entre 0 y 1.  
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
   Extiende la regresión lineal agregando términos polinómicos para capturar relaciones no lineales, se lleva a cabo porque las estrellas más masivas tienden a tener más planetas hasta cierto límite.  

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

**RETORNO DE LA FUNCIÓN:** Un valor de RMSE (Root Mean Squared Error) para cada modelo de regresión. Este se obtiene dentro de la función con base en el resultado de planetas obtenido para cada modelo y el número de planetas correspondiente en la base de datos (valor teórico), a partir del cual se determina la lejanía o desfase de cantidad de planetas que tiene el modelo experimental, en promedio, con respecto al modelo teórico.

*RMSE:* El RMSE mide el promedio del error cuadrático entre lo real y lo predicho. Un RMSE más bajo significa que el modelo predice más cerca de los valores reales.

### 4. ANÁLISIS POR TIPO DE ESTRELLA
En esta sección, se generaron 3 diagramas para determinar y analizar las relaciones que presentan distintas variables.

1. Gráfico de barras: *Tasa de planetas por tipo espectral*
   Muestra qué tipos espectrales presentan mayor proporción de estrellas con planetas, en un diagrama cuyo eje x contiene los tipos espectrales y el eje y presenta la proporción de estrellas con planetas.
2. Diagrama H&R: *Diagrama HR (coloreado por presencia de planetas)*
   
3. Clustering: *Clusters de estrellas (k-means)*

### 5. DIAGRAMA HERTZSPRUNG-RUSSELL DE SISTEMAS PLANETARIOS


## RESULTADOS

### 1. Carga de datos  
Al realizar la carga de datos en Matlab, se imprimió con la función `display` una muestra de la tabla de datos obtenida para la matriz de resultados con la que se realizaron las posteriores comparaciones.

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
A continuación se presenta la tabla que contiene en una columna los modelos y en la otra la precisión con respecto al modelo teórico de la bandera (sí/no) que representa la presencia de uno o más planetas orbitando una estrella. 

``` Matlab
Comparación de precisión entre modelos:
            Modelo             Precisión
    _______________________    ________

    {'Regresión Logística'}    0.79878 
    {'Árbol de Decisión'  }    0.89024 
    {'KNN'                }    0.79878 
    {'SVM'                }    0.81707
```

Se evidencia que la mayor precisión la obtuvo el árbol de decisión, debido a que tiene el valor de precisión más alto, correspondiente a 0.89 sobre 1. Es posible que este modelo haya tenido el mejor ajuste porque se caracteriza por sobreajustar los datos.  
Así mismo, el hecho de que no todos los modelos hayan obtenido la misma precisión demuestra que las relaciones entre masa, metalicidad y luminosidad no son exclusivamente lineales para las estrellas.  

### 3. Regresión: Cantidad estimada de planetas
Para la regresión, el resultado obtenido es una comparación de RMSE por el resultado obtenido en cada modelo.  

``` Matlab
Comparación de RMSE entre modelos de regresión:
         Modelo           RMSE  
    _________________    _______

    {'Lineal'       }      1.012
    {'Polinómica'   }     1.0093
    {'Random Forest'}    0.81631
    {'Red Neuronal' }     1.0594
```

### 4. Análisis por tipo de estrella

Figura 1 (barras de proporción de planetas por tipo espectral):
Mostró que ciertos tipos (ej. G y K) tienen mayor proporción de estrellas con planetas.

Figura 2 (HR diagram general):
Visualizó todas las estrellas, coloreadas por presencia de planetas. Se observó concentración en la secuencia principal.
TODAS LAS ESTRELLAS SE ENCUENTRAN EN LA SECUENCIA PRINCIPAL, NO SON GIGANTES NI SUPERGIGANTES, NI TAMPOCO ENANAS BLANCAS

Figura 3 (clusters con k-means):
Agrupó estrellas por masa y luminosidad, mostrando que algunos clusters tienen más planetas, lo que sugiere patrones de formación.

Conclusión: El análisis espectral confirmó que los tipos de estrella influyen en la probabilidad de tener planetas y que existen regiones del HR donde se concentran más.

### 5. Diagrama H&R de las estrellas con planetas

Figura (HR filtrado):
Mostró únicamente las estrellas con planetas. Se observó que la mayoría se concentran en la secuencia principal y en tipos espectrales intermedios (G, K).

Interpretación:
Esto conecta directamente con la clasificación binaria y el análisis espectral: los modelos predicen bien porque efectivamente hay patrones físicos detrás.

Conclusión: El HR filtrado es la evidencia visual más clara de dónde se encuentran las estrellas con planetas, reforzando todo el pipeline del proyecto.

### Vídeo de presentación del proyecto:


## REFLEXIÓN SOBRE IA
### Implementación de la IA en el proyecto


### Prompts utilizados con Copilot
En el archivo titulado `prompts_Copilot.txt` se encuentran todos los prompts enviados a esta inteligencia artificial generativa con el objetivo de recibir ayuda para realizar los análisis, arreglar errores y resolver dudas en el proceso de desarrollo del proyecto, la implementación de las clasificaciones, regresiones y gráficas.

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
