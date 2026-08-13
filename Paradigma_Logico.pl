

% Hechos
animal(perro).
animal(gato).
animal(caballo).

edad(perro, 5).
edad(gato, 3).
edad(caballo, 10).


% FINDALL
% Buscamos todos los animales y los guardamos en una lista.
% Consulta:
% ?- findall(X, animal(X), Animales).
%
% Resultado:
% Animales = [perro, gato, caballo].


% Otro ejemplo:
% Buscamos todas las edades.
% ?- findall(Edad, edad(Animal, Edad), Edades).
%
% Resultado:
% Edades = [5, 3, 10].


% Podemos usar findall dentro de una función:
cantidadAnimales(Cantidad) :-
    findall(X, animal(X), Animales),
    length(Animales, Cantidad).

% Consulta:
% ?- cantidadAnimales(Cantidad).
%
% Resultado:
% Cantidad = 3