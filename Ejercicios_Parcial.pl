

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
