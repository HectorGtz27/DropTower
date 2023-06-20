clear; clc; clf;

% Condiciones de la espira
m = 0.01;% Masa del electroimán (kg)
g = 9.81; % Constante de aceleración de la gravedad (m/s^2)
U = 1000000; % Momento dipolar magnético
M = 4*pi*10^-7; % Constante de permeabilidad magnética
a = 0.08; % Radio de la espira (m)
r = 1.71*10^-8; % Resistencia del cobre a temperatura ambiente

% Funciones de velocidad (v) y posición (z), que representan las ecuaciones
% diferenciales de la velocidad (v) y posicion (z) respectivamente. Estas
% dependen del tiempo(t), la posicion(z) y la velocidad(v)
f1 = @(t, z, v) v;
%Cual es esta formula? Es la formula de la acceleraion
f2 = @(t, z, v) (-(m*g) - ((9*((M*U)^2)*(a^4))/(4*r))*((z^2)/((z^2+a^2)^5))*v)/m;

% Tiempo inicial y tiempo final
t0 = 0;
tf = 5;

% Fracción de tiempo o (paso??)
delta = 0.0001;

% Posición inicial y velocidad inicial
z0 = 30; %En Z
v0 = 0;

% Se crea un vector de tiempo (t) que va desde t0 hasta tf con incrementos
% de delta
t = t0:delta:tf;

% Longitud del vector de tiempo
L = length(t);

% Creación de los vectores de tiempo, posición y velocidad
%Se crean vectores vacios para almacenar la posicion y la velocidad
%respectivamente
Z = zeros(1, L);
V = zeros(1, L);

% Declaración de la posición y la velocidad inicial
%Se asigna la posicion y la velocidad inical al primer elemento de los
%vectores Z y V respectivamente
Z(1) = z0;
V(1) = v0;

% Implementación del método de Runge-Kutta de cuarto orden para calcular
% los valores de posicion y velocidad en cada paso de tiempo. El bucle for
% se repite L-1 veces
for i = 1:(L-1)
    %Aqui se utilizan las funciones
    k1_1 = f1(t(i), Z(i), V(i));
    k1_2 = f2(t(i), Z(i), V(i));

    k2_1 = f1(t(i)+1/2*delta, Z(i)+1/2*k1_1*delta, V(i)+1/2*k1_2*delta);
    k2_2 = f2(t(i)+1/2*delta, Z(i)+1/2*k1_1*delta, V(i)+1/2*k1_2*delta);
    
    k3_1 = f1(t(i)+1/2*delta, Z(i)+1/2*k2_1*delta, V(i)+1/2*k2_2*delta);
    k3_2 = f2(t(i)+1/2*delta, Z(i)+1/2*k2_1*delta, V(i)+1/2*k2_2*delta);

    k4_1 = f1(t(i)+delta, Z(i)+k3_1*delta, V(i)+k3_2*delta);
    k4_2 = f2(t(i)+delta, Z(i)+k3_1*delta, V(i)+k3_2*delta);

    %Se actualizan los valores de posicion Z y V en cada paso de tiempo
    Z(i+1) = Z(i) + 1/6 * (k1_1 + 2*k2_1 + 2*k3_1 + k4_1) * delta;
    V(i+1) = V(i) + 1/6 * (k1_2 + 2*k2_2 + 2*k3_2 + k4_2) * delta;
end

% Graficación
% Figura 1 muestra la posicion en funcion del tiempo
figure(1);
plot(t, Z, 'b', 'LineWidth', 1.5)
xlabel('Tiempo (s)');
ylabel('Posición (m)');
title('Posición respecto al tiempo');

% Figura 2 muestra la velocidad en funcion del tiempo
figure(2);
plot(t, V, 'r', 'LineWidth', 1.5)
xlabel('Tiempo (s)');
ylabel('Velocidad (m/s)');
title('Velocidad respecto al tiempo');

% Figura 3 muestra la acceleracion en funcion del tiempo 
% Se obtiene un vector de aceleración con los diferenciales de velocidad con respecto al tiempo
% diff(V) calcula la diferencia entre elementos consecutivos del vector de
% velocidad V. diff(t) calcula la diferencia entre elementos consecutivos.
% Se utiliza la funcion diff porque la acceleracion se define como la tasa
% de cambio de la velocidad en funcion del tiempo.
acceleracion = diff(V) ./ diff(t);
figure(3);
%Se utiliza t(1:end-1) para obtener todos los elementos de t desde el
%primer elemento hasta el penultimo elemento. Se excluye el ultimo
%elementos porque el vector de tiempo y acceleracion deben de ser de la
%misma longitud.
plot(t(1:end-1), acceleracion, 'g', 'LineWidth', 1.5)
xlabel('Tiempo (s)');
ylabel('Aceleración (m/s^2)');
title('Aceleración respecto al tiempo');


%-------------------- Graficas Combinadas -------------------------------------

% Figura 1 muestra la posición en función del tiempo
figure;
plot(t, Z, 'b', 'LineWidth', 1.5)
xlabel('Tiempo (s)');
hold on;

% Figura 2 muestra la velocidad en función del tiempo
plot(t, V, 'r', 'LineWidth', 1.5)
xlabel('Tiempo (s)');

% Figura 3 muestra la aceleración en función del tiempo
plot(t(1:end-1), acceleracion, 'g', 'LineWidth', 1.5)
xlabel('Tiempo (s)');

title('Gráficas de posición, velocidad y aceleración en función del tiempo');
legend('Posición', 'Velocidad', 'Aceleración');
hold off;
