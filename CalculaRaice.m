clc;
clear;

fprintf('=============================================\n');
fprintf('       RAICES DEL POLINOMIO CARACTERISTICO\n');
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

%% Mostrar vector de coeficientes
fprintf('\nVector de coeficientes:\n');
disp(a);

%% Calcular las raíces
polos = roots(a);

%% Mostrar los polos
fprintf('=============================================\n');
fprintf('              POLOS DEL SISTEMA\n');
fprintf('=============================================\n\n');

for k = 1:n
    fprintf('Polo %d = %12.6f %+.6fj\n', ...
        k, real(polos(k)), imag(polos(k)));
end

%% Clasificación de los polos
derecho = 0;
izquierdo = 0;
eje = 0;

tolerancia = 1e-10;

for k = 1:n

    parteReal = real(polos(k));

    if parteReal > tolerancia
        derecho = derecho + 1;

    elseif parteReal < -tolerancia
        izquierdo = izquierdo + 1;

    else
        eje = eje + 1;
    end

end