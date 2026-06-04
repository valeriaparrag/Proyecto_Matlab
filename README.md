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
   Es un modelo estadístico que estima la probabilidad de que ocurra un evento binario en el que 1 es sí y 0 es no. 
   **Funcionamiento:** 
   Usa una función logística (sigmoide) para transformar una combinación lineal de variables predictoras en una probabilidad entre 0 y 1. Si la probabilidad es mayor a un umbral (0.5), clasifica como “1” (estrella con planetas), si no, clasifica como "0" (estrella sin planetas). 
   **Función** `fitglm` **:** 
   fitglm corresponde a la abreviación de Fit Generalized Linear Model. 
   Esta función ajusta un modelo lineal generalizado, calculando la probabilidad de que la respuesta sea 1 en función de las variables predictorias. 
   En este caso, haciendo uso de 'Distribution' y 'binomial' este modelo lineal se convierte en una regresión logística, cuya salida es un objeto modelo (variable `mdl_log`) que tiene coeficientes, estadísticas y un método predict para estimar probabilidades. 


2. Árbol de decisión - `fitctree` 
   Es un modelo que divide los datos en ramas según reglas simples.
   **Funcionamiento:** 
   Construye un árbol donde cada nodo representa una condición sobre una variable, las hojas del árbol representan la clasificación final (planetas sí/no). 
   **Función** `fitctree` **:** 
   fitctree corresponde a la abreviación de Fit Classification Tree. 
   Esta función entrena un árbol de decisión para clasificación, dividiendo los datos en ramas según condiciones sobre las variables predictoras, hasta llegar a hojas que representan la clase final. 
   En este caso, la salida de la función es un objeto árbol (mdl_tree) que se puede visualizar con
   `` Matlab
   view(mdl_tree,'Mode','graph')
   ``

4. k-Nearest Neighbors (KNN) - `fitcknn`
   Es un modelo basado en la similitud entre observaciones. 
   **Funcionamiento:** 
   Para clasificar una estrella, busca las k estrellas más cercanas en el espacio de variables predictoras, y clasifica según la mayoría de esas vecinas (ejemplo: si 4 de 5 vecinas tienen planetas, se predice “con planetas”). 
   **Función** `fitcknn` **:** 
   fitcknn corresponde a la abreviación de Fit Classification k-Nearest Neighbors. 
   Esta función entrena un modelo de vecinos más cercanos.

Qué hace: Para clasificar un punto nuevo, busca los k puntos más cercanos en el conjunto de entrenamiento y asigna la clase mayoritaria.

Salida: Un objeto KNN (mdl_knn) que usa predict para clasificar nuevos datos.

   

4. Support Vector Machines (SVM) - `fitcsvm`
Qué es: Un modelo que busca el “mejor hiperplano” que separa las dos clases.

Cómo funciona:

Encuentra una frontera que maximiza la distancia entre las clases (estrella con planetas vs. sin planetas).

Con kernels (como el radial rbf), puede manejar separaciones no lineales.

Ventaja: Muy potente para datos complejos y no lineales.

Limitación: Menos interpretable y puede ser más pesado computacionalmente.

### 

## RESULTADOS

## REFLEXIÓN SOBRE IA
### Implementación de la IA en el proyecto

### Prompts utilizados con Copilot

## CONCLUSIONES

## REFERENCIAS

## AUTORA
Valeria Andrea Parra García - valeriaparrag@javeriana.edu.co
