%% Clasificación binaria con 4 métodos:
%   - Regresión Logística
%   - Árbol de Decisión
%   - k-Nearest Neighbors (KNN)
%   - Support Vector Machines (SVM)
%
% Entradas:
%   T - tabla con datos de estrellas
%   y - vector binario (1=con planetas, 0=sin planetas)
%
% Salida:
%   resultados - estructura con los 4 modelos entrenados

function resultados = clasificacion_binaria(T, y)

% Selección de variables predictoras
X = [T.StMass, T.StMet, T.StLum];

%% 1. Regresión Logística
mdl_log = fitglm(X, y, 'Distribution','binomial');
yhat_log = round(predict(mdl_log, X));

%% 2. Árbol de Decisión
mdl_tree = fitctree(X, y);
yhat_tree = predict(mdl_tree, X);

%% 3. KNN
mdl_knn = fitcknn(X, y, 'NumNeighbors',5);
yhat_knn = predict(mdl_knn, X);

%% 4. SVM
mdl_svm = fitcsvm(X, y, 'KernelFunction','rbf','Standardize',true);
yhat_svm = predict(mdl_svm, X);

%% Guardar en estructura
resultados.logistica.modelo = mdl_log;
resultados.logistica.predicciones = yhat_log;

resultados.tree.modelo = mdl_tree;
resultados.tree.predicciones = yhat_tree;

resultados.knn.modelo = mdl_knn;
resultados.knn.predicciones = yhat_knn;

resultados.svm.modelo = mdl_svm;
resultados.svm.predicciones = yhat_svm;
end
