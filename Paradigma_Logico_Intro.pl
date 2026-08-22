

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

%Para evitar esto uso el predicado ? distinct(afortunado(Persona).  devuelve solo una vez a tefi