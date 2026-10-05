clc;
clear;

fprintf('=============================================\n');
fprintf('       TABLA DE ROUTH-HURWITZ\n');
fprintf('=============================================\n\n');

%% Solicitar orden del polinomio
n = input('Ingrese el orden del polinomio n: ');

%% Solicitar coeficientes
fprintf('\nIngrese los coeficientes del polinomio:\n');
fprintf('P(s) = a0*s^n + a1*s^(n-1) + ... + an\n\n');

a = zeros(1,n+1);

for k = 0:n
    a(k+1) = input(sprintf('a%d = ',k));
end

%% Mostrar polinomio
fprintf('\nPolinomio ingresado:\n');
disp(a);

%% Número de columnas de la tabla
numFilas = n + 1;
numColumnas = ceil((n + 1)/2);

%% Inicializar tabla de Routh
R = zeros(numFilas,numColumnas);

%% Primera fila: s^n
R(1,1:numColumnas) = a(1:2:end);

%% Segunda fila: s^(n-1)
R(2,1:length(a(2:2:end))) = a(2:2:end);

%% Construcción de la tabla
for i = 3:numFilas
    
    for j = 1:numColumnas-1
        
        % Coeficiente de la fila actual
        R(i,j) = (R(i-1,1)*R(i-2,j+1) ...
                 -R(i-2,1)*R(i-1,j+1)) / R(i-1,1);
    end
    
end

%% Mostrar tabla
fprintf('\n=============================================\n');
fprintf('          TABLA DE ROUTH-HURWITZ\n');
fprintf('=============================================\n\n');

for i = 1:numFilas
    
    exponente = n-(i-1);
    
    fprintf('s^%-2d | ',exponente);
    
    for j = 1:numColumnas
        fprintf('%12.4f ',R(i,j));
    end
    
    fprintf('\n');
end

%% Primera columna
primeraColumna = R(:,1);

fprintf('\nPrimera columna:\n');
disp(primeraColumna);

%% Verificar fila completa de ceros
for i = 1:numFilas
    
    if all(abs(R(i,:)) < 1e-12)
        
        fprintf('\n*** ADVERTENCIA ***\n');
        fprintf('La fila correspondiente a s^%d es completamente cero.\n', ...
                n-(i-1));
        fprintf('El script NO utiliza el polinomio auxiliar.\n');
        fprintf('La tabla se muestra hasta donde fue posible calcularla.\n');
        
        break;
    end
end

%% Contar cambios de signo
cambios = 0;

for i = 1:length(primeraColumna)-1
    
    if primeraColumna(i)*primeraColumna(i+1) < 0
        cambios = cambios + 1;
    end
    
end

fprintf('\n=============================================\n');
fprintf('ANALISIS DE LA PRIMERA COLUMNA\n');
fprintf('=============================================\n');

fprintf('Numero de cambios de signo = %d\n',cambios);

fprintf('\nPor el criterio de Routh-Hurwitz:\n');
fprintf('Polos en el semiplano derecho = %d\n',cambios);

polosIzquierda = n - cambios;

fprintf('Polos restantes = %d\n',polosIzquierda);

fprintf('\n');