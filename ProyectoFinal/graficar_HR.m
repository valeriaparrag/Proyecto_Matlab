%% HR específico de estrellas con planetas
% Objetivo:
%   Generar un diagrama HR solo con las estrellas que tienen planetas,
%   para analizar en qué zonas del diagrama se concentran.
%
% Entradas:
%   T - tabla con datos de estrellas (incluye SyBvmag, StLum, StSpectype)
%   MatrizValidacion - tabla con bandera de planetas (PlanetasFlag)
%
% Salida:
%   hr_planetas - estructura con índices filtrados y gráfico generado

function hr_planetas = graficar_HR(T, MatrizValidacion)

% Filtrar estrellas con planetas
flagBinario = strcmp(MatrizValidacion.PlanetasFlag,'Y');
idx = flagBinario == 1;
T_filtrado = T(idx,:);

% HR diagram con escala log
figure;
scatter(T_filtrado.SyBvmag, T_filtrado.StLum, 25, 'filled'); % tamaño 25
xlabel('Índice de color B-V');
ylabel('Luminosidad (escala log)');
title('Diagrama HR - Estrellas con planetas');
set(gca,'YScale','log'); % escala log típica
grid on;

% Ajustar límites para que se vea mejor
xlim([-0.5 2.5]); % rango típico de B-V
ylim([0.01 1e4]); % rango típico de luminosidad


% Guardar resultados
hr_planetas.indices = idx;
hr_planetas.tabla_filtrada = T_filtrado;
end

