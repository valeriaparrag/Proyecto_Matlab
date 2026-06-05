%% Cartografía Estelar de Exoplanetas: Inferencia y Visualización en MATLAB
% Autor: Valeria Parra
% Fecha: [10/03/2026]

%% Configuración inicial
clear       % limpiar variables del workspace
clc         % limpiar ventana de comandos
close all   % cerrar todas las figuras

%% 1. CARGAR DATOS
% Las dos salidas que reciben 
[T, MatrizValidacion] = cargar_datos('datos_estrellas.xlsx');

disp(MatrizValidacion(1:10,:)) % muestra las primeras 10 filas para verificar que los datos se hayan cargado correctamente


%% 2. CLASIFICACIÓN BINARIA
% Convertir etiquetas a binario
y = strcmp(MatrizValidacion.PlanetasFlag,'Y');

% Entrenar modelos
resultados = clasificacion_binaria(T, y);

%% COMPARACIÓN DE MÉTODOS
acc_log  = mean(resultados.logistica.predicciones == y);
acc_tree = mean(resultados.tree.predicciones == y);
acc_knn  = mean(resultados.knn.predicciones == y);
acc_svm  = mean(resultados.svm.predicciones == y);

comparacion = table({'Regresión Logística';'Árbol de Decisión';'KNN';'SVM'}, [acc_log; acc_tree; acc_knn; acc_svm], 'VariableNames', {'Modelo','Precisión'});

disp('Comparación de precisión entre modelos:');
disp(comparacion);

%% 3. REGRESIÓN (estimación de número de planetas)
y_numPlanetas = MatrizValidacion.NumPlanetas; % columna con número real de planetas

resultados_reg = regresion_planetas(T, y_numPlanetas);

% Comparar desempeño con RMSE (Root Mean Squared Error)
rmse_lin  = sqrt(mean((resultados_reg.lineal.predicciones - y_numPlanetas).^2));
rmse_poly = sqrt(mean((resultados_reg.polynomial.predicciones - y_numPlanetas).^2));
rmse_rf   = sqrt(mean((resultados_reg.randomforest.predicciones - y_numPlanetas).^2));
rmse_nn   = sqrt(mean((resultados_reg.neuralnet.predicciones - y_numPlanetas).^2));

comparacion_reg = table({'Lineal';'Polinómica';'Random Forest';'Red Neuronal'}, [rmse_lin; rmse_poly; rmse_rf; rmse_nn], 'VariableNames', {'Modelo','RMSE'});

disp('Comparación de RMSE entre modelos de regresión:');
disp(comparacion_reg);

%% 4. ANÁLISIS TIPOS DE ESTRELLA

analisis = analisis_tipos(T, MatrizValidacion);

%% 5. H&R DE ESTRELLAS CON PLANETAS

hr_planetas = graficar_HR(T, MatrizValidacion);
