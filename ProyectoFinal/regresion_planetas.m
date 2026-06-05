%% Regresión de cantidad de planetas con 4 métodos:
%   - Regresión Lineal Múltiple (fitlm)
%   - Regresión Polinómica (fitlm con términos cuadráticos)
%   - Random Forest Regressor (TreeBagger)
%   - Red Neuronal (fitnet)
%
% Entradas:
%   T - tabla con datos de estrellas
%   y_numPlanetas - vector numérico con el número real de planetas por estrella
%
% Salida:
%   resultados - estructura con los 4 modelos entrenados y sus predicciones


function resultados = regresion_planetas(T, y_numPlanetas)
% Selección de variables predictoras
X = [T.StMass, T.StMet, T.StLum];

%% 1. Regresión lineal múltiple
mdl_lin = fitlm(X, y_numPlanetas);
yhat_lin = predict(mdl_lin, X);

%% 2. Regresión polinómica (grado 2)
X_poly = [X, X.^2]; % añadir términos cuadráticos
mdl_poly = fitlm(X_poly, y_numPlanetas);
yhat_poly = predict(mdl_poly, X_poly);

%% 3. Random Forest Regressor
mdl_rf = TreeBagger(50, X, y_numPlanetas, 'Method','regression');
yhat_rf = predict(mdl_rf, X);

%% 4. Red neuronal
net = fitnet(10); % 10 neuronas en capa oculta
net = train(net, X', y_numPlanetas'); % transponer la matriz
yhat_nn = net(X')'; % volver a vector columna

%% Guardar resultados
resultados.lineal.modelo = mdl_lin;
resultados.lineal.predicciones = yhat_lin;

resultados.polynomial.modelo = mdl_poly;
resultados.polynomial.predicciones = yhat_poly;

resultados.randomforest.modelo = mdl_rf;
resultados.randomforest.predicciones = yhat_rf;

resultados.neuralnet.modelo = net;
resultados.neuralnet.predicciones = yhat_nn;
end
