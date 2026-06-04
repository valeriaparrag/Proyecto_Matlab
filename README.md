# Cartografía Estelar de Exoplanetas: Inferencia y Visualización en MATLAB
## DESCRIPCIÓN DEL PROYECTO  
Este proyecto aplica técnicas de procesamiento de datos, clasificación estadística y visualización científica para analizar un conjunto de estrellas del NASA Exoplanet Archive. A partir de parámetros físicos como masa, metalicidad, luminosidad, amplitud radial y actividad cromosférica, se desarrolla un sistema de inferencia de planetas dividido en dos enfoques complementarios:

Clasificación binaria: predicción de la presencia o ausencia de planetas mediante métodos estadísticos y de aprendizaje supervisado (regresión logística, árboles de decisión, SVM).

Regresión: estimación del número potencial de planetas asociados a cada estrella utilizando modelos de regresión lineal, polinómica y ensambles como Random Forest.

El análisis se complementa con un estudio de los tipos espectrales de estrellas, explorando la relación entre clase estelar y probabilidad de albergar sistemas planetarios. Además, se construyen diagramas de Hertzsprung-Russell (HR), tanto generales como filtrados para estrellas con planetas, con el fin de identificar las regiones del diagrama donde se concentran los sistemas planetarios más frecuentes.

La implementación se realiza en MATLAB, integrando importación y limpieza de datos, funciones modulares, visualizaciones 2D y 3D, clustering estadístico y dashboards interactivos. El proyecto culmina con un Live Script documentado, que incluye reflexión crítica sobre el uso de herramientas de IA generativa (MATLAB Copilot) en el proceso de desarrollo.

## JUSTIFICACIÓN


## DESARROLLO: SECCIONES DEL PROYECTO
### Estructura del proyecto
Este proyecto se encuentra en una carpeta llamada `ProyectoFinal`. Dentro de ella, están los siguientes archivos:
1. `funcion_principal.m`: Esta función es el "main" del proyecto, en ella se llaman todas las funciones secundarias para que corran en el orden en el que se desean obtener los resultados; presenta la estructura general del proyecto y realiza los análisis comparativos entre los modelos implementados en el proyecto. 
2. `cargar_datos.m`: Función para realizar la carga de datos del archivo `datos_estrellas.xlsx` a dos matrices en Matlab, con las cuales se realizaría el posterior procesamiento de datos. 
3. `clasificacion_binaria.m`: Función en la que se aplican los 4 métodos de clasificación binaria con los cuales se determinaría si una estrella tiene o no planeta(s). 
4. `regresion_planetas.m`:
5. `graficar_HR.m`:
6. `datos_estrellas.xlsx`: Archivo de Excel con la base de datos completa descargada.

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

**RETORNO DE LA FUNCIÓN: ** en la función se retorna resultados, una estructura que contiene cada modelo entrenado (objeto que guarda parámetros, coeficientes, etc.) en `T` y las predicciones que ese modelo hizo sobre los datos de entrada en `y`, la cual se calcula como un valor de precisión entre 0 y 1.  
``` Matlab
resultados = clasificacion_binaria(T, y);
```

### 3. Regresión: cantidad estimada de planetas  

1. Regresión lineal múltiple - `fitlm`  

2. Regresión polinómica  

3. Random Forest Regressor - `TreeBagger`  

4. Redes neuronales - `fitnet`  

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
            Modelo             Accuracy
    _______________________    ________

    {'Regresión Logística'}    0.79878 
    {'Árbol de Decisión'  }    0.89024 
    {'KNN'                }    0.79878 
    {'SVM'                }    0.81707
```

## REFLEXIÓN SOBRE IA
### Implementación de la IA en el proyecto

### Prompts utilizados con Copilot

## CONCLUSIONES

## REFERENCIAS

## AUTORA
Valeria Andrea Parra García - valeriaparrag@javeriana.edu.co
