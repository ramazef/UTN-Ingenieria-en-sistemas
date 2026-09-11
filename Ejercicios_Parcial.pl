

% Segundo requerimiento: lenguaje copado

% Aquel en el que todas las personas que lo programan son las ideales: 
% ganan bastante (más de 100 mangos la hora) o programan bien.
 

programaEn(nahuel, javascript).
programaEn(juan, haskell).
programaEn(juan, prolog).
programaEn(caro, prolog).
programaEn(valen, prolog).
programaEn(hernan, smalltalk).

programaBien(juan).
programaBien(valen).

gana(caro, 150).
gana(juan, 40).
gana(valen, 90).
gana(hernan, 80).

%el output se que va a ser una consulta existencial que devuelva a prolog xq caro gana bien y haskell pq solo juan programa en ese lenguaje y lo hace bien.
%Es un OR, voy a tener 2 reglas. Las reglas deben tener el mismo nombre.

% forall( p, q )
% forall(predicadoQuemevaAservirParaArmarElUniverso, PredicadoQueEstableceCondicionesACumplir)
% en criollo forall(deDondeSaco, laCondicion)

% lenguajeCopado(Lenguaje) es cierto si:
% - Lenguaje es un lenguaje válido (generador)
% - Y TODAS las personas que programan en ese lenguaje son ideales

lenguajeCopado(Lenguaje) :-                %tiene un parámetro porque la relación "ser copado" es una propiedad de un lenguaje
    lenguaje(Lenguaje),                    %Que es lo que queremos ligar antes del forall? Seteo el universo con el que quiero trabajar(generador). Su único trabajo es: "dame todos los lenguajes que existen en la base, uno por uno"
    forall(programaEn(Persona, Lenguaje),
           personaIdeal(Persona)).          %Use un predicado auxiliar para modelizar una persona ideal

% lenguaje(Lenguaje) genera cada lenguaje una sola vez (sin repetidos),
% usando distinct/2 sobre los que aparecen en programaEn/2.
% Esto es lo que le da el generador a lenguajeCopado para poder usar forall.
lenguaje(Lenguaje) :-
    distinct(Lenguaje,
             programaEn(_, Lenguaje)).

% personaIdeal(Persona) es cierto si gana más de 100 por hora...
personaIdeal(Persona) :- gana(Persona, Monto),
    Monto > 100.

% ...o si programa bien (OR armado con 2 cláusulas separadas)
personaIdeal(Persona) :- programaBien(Persona).

% El menor de una lista es aquel que es menor o igual que todos los otros elementos: 
% para todo elemento que no sea ése, el menor es <= que cada elemento.

menor(Lista, Menor) :-
    member(Menor, Lista),
    forall(member(Elemento, Lista), Menor =< Elemento).

menorNot(Lista, Menor) :-
    member(Menor, Lista),
    not((member(Elemento, Lista), Elemento < Menor)).


%Ambas soluciones estan bien. ahora hacemos otro ejemplo donde es preferible un predicado que el otro.


%Lenguaje shipeado: a todos los que programan en ese lenguaje les gusta.

% Se que el output va a ser wollok y haskell pq a juan no le gusta programar en prolog.
programaEn(juan, haskell).
programaEn(juan, prolog).
programaEn(caro, prolog).
programaEn(valen, prolog).
programaEn(rocio, wollok).
programaEn(nahuel, wollok).
programaEn(nahuel, javascript).
programaEn(nahuel, haskell).

leGusta(rocio, wollok).
leGusta(nahuel, wollok).
leGusta(juan, haskell).
leGusta(nahuel, haskell).
leGusta(caro, prolog).

lenguaje(Lenguaje) :- distinct(Lenguaje, programaEn(_, Lenguaje)).


lenguajeShipeado(Lenguaje) :-
    lenguaje(Lenguaje),
    forall(programaEn(Persona, Lenguaje), leGusta(Persona, Lenguaje)).


lenguajeShipeadoNot(Lenguaje) :-
    lenguaje(Lenguaje),
    not((programaEn(Persona, Lenguaje), not(leGusta(Persona, Lenguaje)))).

%Como se puede apreciar, forall es bastante mas expresivo -facil de leer-. Si me queda un not-not en alguna declaracion probablemente deba aplicar un forall.



%findall: aridad 3.  

%findall(incognita, consulta, una incognita con la lista de individuos que satisface). devuelve una lista! no tira de a uno por backtracking.
%Si haces findall de algo que no tenes , te devuelve una lista vacia.
%Setof funciona similar pero te va a devolver false -tmb no muestra duplicados-.

%Length aridad 2 length(lista,algo=tanto) algo=tanto es lo que va a devolver.

%%%%% Agregacion. otro tema importante para el parcial:

%Base de ejemplo:
nota(pdp, vera, 9).
nota(pdp, dauria, 8).
nota(pdp, krasuk, 6).
nota(pdp, goffredo, 6).
nota(pdp, bardelli, 9).
nota(pdp, gimenez, 2).
nota(pdp, benitez, 2).
nota(pdp, margiotta, 8).
nota(sysop, dauria, 10).
nota(sysop, krasuk, 2).
nota(sysop, goffredo, 9).
nota(discreta, krasuk, 3).
nota(discreta, goffredo, 6).

materia(pdp).
materia(sysop).
materia(discreta).



%Esto es por consola, pregunta cuantos rindieron pdp.
%?- findall(Persona, nota(pdp, Persona, _), Personas), length(Personas, Cuantas).
%Personas = [vera, dauria, krasuk, goffredo, bardelli, gimenez, benitez, margiotta],
%Cuantas = 8.


%La forma practica de acordarse los parametros es "que quiero asociar" en este caso una materia a la cantidad q rindieron.

cuantosRindieron(Materia, Cuantas) :-
    findall(Persona, nota(Materia, Persona, _), Personas),
    length(Personas, Cuantas).

%Cuantas personas rindieron en general
?- cuantosRindieron(Materia, Cuantas).
Cuantas = 13.

%Para saber cuantos rindieron x materia necesito generadores.

cuantosRindieron(Materia, Cuantas) :-
    materia(Materia),                                           %Este unico generador va a devolver x backtracking las 3 materias x separado con sus respectivos alumnos.
    findall(Persona, nota(Materia, Persona, _), Personas),
    length(Personas, Cuantas).

cuantosAprobaron(Materia, Cuantas) :-
    materia(Materia),                                           %Este unico generador va a devolver x backtracking las 3 materias x separado con sus respectivos alumnos.
    findall(Persona, (nota(Materia, Persona, Nota) , Nota >=6 ), Personas),        %Controlo que mantenga la aridad !
    length(Personas, Cuantas).


%Medalla de honor con promedio >7


%Sum list: 1er argumento (entra): una lista de números → [9, 8, 6]
%          2do argumento (sale): el número con la suma → 23

% "is" fuerza a evaluar una operación aritmética y unifica el resultado con lo de la izquierda.


%agregateall tmb de aridad 3.


%Materia amena: materia promocionada por mas de 3 personas.

materiaAmena(Materia) :-
    materia(Materia),
    aggregate_all(count, (nota(Materia, _, Nota), Nota >= 8), CantidadPromocionadas),
    CantidadPromocionadas > 3.

%Resumen de agregate:  es la versión "todo en uno" de la agregación: hace en una sola línea lo que antes hacías con findall + operación sobre la lista. 
%Te evita tener que armar la lista intermedia a mano.

% aggregate_all(QuéCalcular, Meta, Resultado)

1er arg: qué operación querés (count, sum, max, min, bag, set)          Es CLAVE entender q van como primer argumento, 
2do arg: la meta/consulta que se va a evaluar con backtracking
3er arg: dónde te devuelve el resultado

count puntual: cuenta cuántas veces la Meta tiene éxito (cuántas soluciones encuentra por backtracking).

%Aggregate count sum.


% Materia heavy: la nota mas alta es menor a 8.

materiaHeavy(Materia) :-
    materia(Materia),
    aggregate_all(max(Nota), nota(Materia, _, Nota), MaximaNota),
    MaximaNota < 8.


personasQuePromocionan(Personas) :-
    aggregate_all(
        set(Persona),
        (nota(_, Persona, Nota), Nota >= 8),
        Personas).

%set te devuelve una lista ordenada y sin repetidos con todos los valores que toma la variable.




% DECISIONES DE DISEÑO: 

% Predicados individuales vs formato lista.  

%Si me interesa el orden uso una lista, sino predicado simple.

juega(pablo, rasti).
juega(pablo, bloques).

%vs

juega(pablo, [rasti, bloques]).