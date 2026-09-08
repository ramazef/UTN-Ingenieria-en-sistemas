

%Primero definimos base de conocimiento: hechos + reglas.
 
pastas(ravioles).   %Es un hecho , por lo tanto siempre cierto.
pastas(fideos).
pastas(sorrentinos).
pastas(fetuccini).


%1 Preguntas individuales: devuelve True o False.
%Ej pastas(ravioles). %True


%Preguntas de existe: pastas(_) devuelve un true por cada pasta. usando la variable anonima.

%2 preguntas existenciales: queremos saber que individuos satisfacen

%Ej pastas(Cual).   la mayuscula en Cual indica que es una variable, y devuelve todas las pastas, a medida que avanza operador ";"

%Backtracing: permite a prolog encontrar multiples soluciones. Consigue una solucion, deja la marca de backtracking y lo guarda como checkpoint
%luego avanza a la siguiente solucion, y asi sucesivamente hasta que no haya mas soluciones.



plato(ravioles,fileto).  %es de aridad 2. es una relacion poliadica.
plato(ravioles,bolognesa).
plato(sorrentinos,cuatroQuesos).

%Ejemplo consulta:  plato(Pasta, fileto). devuelve todas las pastas que tienen fileto
%consulta: plato(sorrentinos, Salsa). devuelve todas las salsas que tienen sorrentinos (cuatroQuesos)

%consulta 2 variables a la vez: plato(Pasta, Salsa). devuelve todas las combinaciones de pastas y salsas.

%Que podamos hacer consultas existenciales por cualquier parametro es el principio de inversibilidad.


%Regla: Tiene antecedentes que si se cumplen hacen que la reglase satisfaga.
%Regla: Si p es cierto, entonces q es cierto (modus ponens) p -> q  , en prolog se escribe q :- p  (clausula de horn) , como un if


humano(socrates).
%En logica seria si humano(Persona) entonces mortal(Persona)  , en prolog se escribe mortal(Persona) :- humano(Persona).

%? - mortal(socrates). devuelve true
%? mortal(deadpool). devuelve false

%Todo lo que no esta en la base de conocimiento se presume falso.

% p y q -> r , se escribe en prolog como r :- p, q.  (clausula de horn).   Uso del operador AND

viveEn(tefi, lanus).
docente(tefi).

afortunado(Persona) :- viveEn(Persona, lanus), docente(Persona).   %es importante que la persona sea la misma

%Cuando quiera usar el operador logico OR lo hago  separando EN 2 reglas distintas. es afortunado si es docente o si vive en lanus. 

afortunado(Persona) :- viveEn(Persona, lanus).
afortunado(Persona) :- docente(Persona). 

%Cuando usamos la disyuncion en logica hace que el mismo individuo pueda cumplir ambas reglas. si preguntara quien es afortunado sale tefi 2 veces

%Para evitar esto uso el predicado ? distinct(afortunado(Persona)).  devuelve solo una vez a tefi

%Predicados orden simple: number, bool, string, etc.

% make. recarga base de conocimientos en SWI prolog.


%%%%%%%%%%%%%%   Predicados de orden superior.

%Not: aridad 1, espera una consulta como parametro. util para definir reglas.

programaEn (nahuel,javascript).

not(programaEn(nahuel,haskell)).
%devuelve true

%definiendo una regla: una persona es outsider si no programa en javascript.

outsider (Persona):-
    not(programaEn(Persona, javacript)).

% ?outsider(nahuel)  devuelve false.   una buena forma de verlo es como en logica, ver de adentro hacia afuera e invertir valor de verdad.

%cuidado si no particularizo, la base de conocimiento sabe lo que es verdadero pero no lo falso.
%Para que el NOT sea inversible tenemos que unificar todas las incognitas antes de evaluar el predicado not/1.


%Buscando una persona que programe en un lenguaje que el resto no.
%La variable lenguaje tiene que ser la misma para que matchee la comparacion.

personaImprescindible(Persona) :-
    programaEn(Persona, Lenguaje),
    not((programaEn(OtraPersona, Lenguaje),  %en mayus pq son variables
    Persona /= OtraPersona)).                  %por backtracking en la segunda sentencia arranca en la misma Persona

    %El primer predicado me sirve para encontrar las personas unificar las personas en las q puedo trabajar
    %El 2do para verificar. el problema seria que not es de aridad 1, por lo q los parentesis deben incluir la 3ra condicion y volverse una conjuncion.
    %Si yo comparara a la Persona con Alguien, como comparo una persona contra una incognita entonces siempre satisface y serian todos imprescindibles.
    %En conclusion, cuando trabajamos con not hay que tener a todas las incognitas unificadas en el argumento de la consulta.
    %not es de orden superior pq espera una consulta como parametro,


%Hallar lenguaje mas dificil. aca no puedo hacer un recorrido con un for o algo de ese estilo.

aprendizaje(javascript, 60).
aprendizaje(haskell, 70).
aprendizaje(scala, 100).
aprendizaje(ruby, 50).

lenguajeMasDificil(Lenguaje):-      %esta ligado a un lenguaje
    aprendizaje(Lenguaje, Tiempo),
    not (aprendizaje(OtroLenguaje, OtroTiempo))




