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
2. `cargar_datos.m`:
3. `clasificacion_binaria.m`:
4. `regresion_planetas.m`:
5. `graficar_HR`:

### 1. Carga de datos

### 2. Clasificación binaria
En esta sección se aplicaron y compararon 4 métodos distintos para predecir de forma binaria si una estrella tiene o no planetas orbitantes, de manera que obtener un 1 representara para cada estrella la presencia de uno o más planetas orbitantes, y obtener un 0 representara la ausencia de planetas orbitando esa estrella. 
Posteriormente, se realizó una comparación con los datos de "Planets Flag" de la base de datos.

1. Regresión logística - `fitglm`
2. Árbol de decisión - `fitctree`
3. k-Nearest Neighbors (KNN) - `fitcknn`
4. Support Vector Machines (SVM) - `fitcsvm`

### 

## RESULTADOS

## REFLEXIÓN SOBRE IA
### Implementación de la IA en el proyecto

### Prompts utilizados con Copilot

## CONCLUSIONES

## REFERENCIAS

## AUTORA
Valeria Andrea Parra García - valeriaparrag@javeriana.edu.co
