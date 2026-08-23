

%Para probar en terminal:

% ===========================
% BASE DE CONOCIMIENTO: ANIMALES. 
% ===========================

% --- Hechos ---
animal(perro).
animal(gato).
animal(aguila).
animal(gallina).
animal(salmon).
animal(tiburon).
animal(rana).

tiene_pelo(perro).
tiene_pelo(gato).

tiene_plumas(aguila).
tiene_plumas(gallina).

pone_huevos(aguila).
pone_huevos(gallina).
pone_huevos(salmon).
pone_huevos(rana).

vive_en_agua(salmon).
vive_en_agua(tiburon).

puede_volar(aguila).

% --- Reglas ---
mamifero(X) :- animal(X), tiene_pelo(X).

ave(X) :- animal(X), tiene_plumas(X).

pez(X) :- animal(X), vive_en_agua(X), pone_huevos(X).

oviparo(X) :- pone_huevos(X).

vuela(X) :- ave(X), puede_volar(X).