%% Análisis por tipos de estrella
% Objetivo:
%   Relacionar el tipo espectral de las estrellas con la presencia y cantidad de planetas.
%   Generar visualizaciones y análisis comparativos.
%
% Entradas:
%   T - tabla con datos de estrellas (incluye StSpectype, StMass, StLum, etc.)
%   MatrizValidacion - tabla reducida con NombreEstrella, PlanetasFlag y NumPlanetas
%
% Salida:
%   analisis - estructura con resultados y gráficos generados

function analisis = analisis_tipos(T, MatrizValidacion)

%% 1. Comparar tasas de planetas por tipo espectral
tipos = categories(categorical(T.StSpectype));
tasas = zeros(size(tipos));
flagBinario = strcmp(MatrizValidacion.PlanetasFlag,'Y'); % convertir a binario

for i = 1:length(tipos)
    idx = strcmp(T.StSpectype, tipos{i});
    tasas(i) = mean(flagBinario(idx)); % ahora sí es numérico
end

figure;
bar(categorical(tipos), tasas);
ylabel('Proporción de estrellas con planetas');
xlabel('Tipo espectral');
title('Tasa de planetas por tipo espectral');

% Ajustar tamaño de fuente
ax = gca;              % obtener el eje actual
ax.FontSize = 5;      % disminución del tamaño de la letra

%% 2. HR diagram filtrado
figure;
scatter(T.SyBvmag, T.StLum, 40, flagBinario, 'filled');
xlabel('Índice de color B-V');
ylabel('Luminosidad');
title('Diagrama HR (coloreado por presencia de planetas)');
colorbar;

%% 3. Cluster analysis por tipo espectral
X = [T.StMass, T.StLum];
[idxCluster, C] = kmeans(X, 3); % ejemplo con 3 clusters

figure;
gscatter(T.StMass, T.StLum, idxCluster);
xlabel('Masa estelar');
ylabel('Luminosidad');
title('Clusters de estrellas (k-means)');

%% Guardar resultados
analisis.tipos = tipos;
analisis.tasas = tasas;
analisis.clusters = idxCluster;
end
