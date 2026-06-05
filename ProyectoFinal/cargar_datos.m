function [T, MatrizValidacion] = cargar_datos(nombreArchivo)
    % Importar y limpiar la base de datos
    T = readtable(nombreArchivo);

    % Seleccionar solo las columnas relevantes para análisis
    variablesUsadas = {'Hostname','StMass','StMet','StLum','StTeff','StSpectype','SyVmag','SyBvmag','SyPlanetsFlag','SyPnum'};
    T = T(:, variablesUsadas);

    % Crear matriz de validación
    nombres      = string(T.Hostname);
    planetasFlag = T.SyPlanetsFlag;
    numPlanetas  = T.SyPnum;

    MatrizValidacion = table(nombres, planetasFlag, numPlanetas,'VariableNames', {'NombreEstrella','PlanetasFlag','NumPlanetas'});
end
