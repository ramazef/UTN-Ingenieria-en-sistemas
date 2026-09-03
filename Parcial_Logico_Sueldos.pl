
/* 
Sueldos 
Una amiga nos pidió que modelemos la lógica de las personas que trabajan en su empresa, 
en base a la siguiente información que nos pasó.

Punto 1: Por la plata baila el mono
Sabemos las personas que trabajan en un departamento. 
Por ejemplo en Ventas trabajan Kyle, Trisha y Joshua, mientras que Ian y Sherri trabajan en Logística.

También tenemos registrado cuánto gana cada persona:
si la persona es asalariada, sabemos cuántas horas trabaja
si la persona tiene gente a cargo, sabemos quiénes son las personas subordinadas, ordenadas por importancia
si la persona es independiente, sabemos cuál es el oficio que tiene

Por ejemplo:
Kyle es asalariado, trabaja 6 horas y gana 50
Sherri es asalariada, trabaja 7 horas y gana 60
Gus es asalariado, trabaja 8 horas y gana 60
Ian es jefe, tiene a su cargo a Kyle, Rob y Ginger, y gana 40
Trisha es jefa, tiene a su cargo a Ian y Gus y gana 90
Joshua es independiente, trabaja de arquitecto y gana 55

*/

%relaciono trabajadores y deptos. no importa que vaya primero.

trabaja_en(kyle, ventas).
trabaja_en(trisha, ventas).
trabaja_en(joshua, ventas).
trabaja_en(ian, logistica).
trabaja_en(sherri, logistica).

% Asalariados: asalariado(Persona, Horas, Sueldo)

asalariado(kyle, 6, 50).         %otra forma: puesto(kyle, asalariado (6) , 50) , esta forma es mejor.    tambien podria tener el puesto y lo que gana por separado, un poco mas modular. 
asalariado(sherri, 7, 60).       %mala forma: puesto(kyle, asalariado(6, 50)) meterle lo que gana en el funtor es malo para preguntar.
asalariado(gus, 8, 60).

%no esta tan bueno tener predicados distintos, es mejor un funtor, todos cumparten una categoria puesto y desp dividis por dentro.

% Jefes: jefe(Persona, Subordinados, Sueldo)

jefe(ian, [kyle, rob, ginger], 40).
jefe(trisha, [ian, gus], 90).

%busco que los dependientes esten en una lista para q pueda ordenarlos por importancia.

%otra forma: puesto (ian, jefe[kyle,rob,ginger])
%gana (ian,40)

% Independientes: independiente(Persona, Oficio, Sueldo)

independiente(joshua, arquitecto, 55).


/*
Punto 2: Paganini
Queremos saber si un departamento es paganini, eso ocurre si todas las personas que trabajan en él ganan bien.

un asalariado gana bien si gana más que el promedio en base a las horas trabajadas.

Por ejemplo: el sueldo promedio de 6 horas es 45, el de 7 horas es 60 y el de 8 80.

un jefe gana bien si gana más de 20 * la cantidad de personas a cargo
y un independiente gana bien si es arquitecto o gana más de 70.
Ventas es un departamento paganini.
El predicado debe ser inversible.
*/

%Pensar en terminos de que quiero que responda, un true/false o varias rtas.
%Que el predicado sea inversible significa que voy a necesitar un generador.
%para preguntar usando la variables jefes 
%Relacionar mentalmente: "si x cosa entonces x cosa" es que voy a usar reglas.


% Promedio según horas trabajadas

promedio(6, 45).
promedio(7, 60).
promedio(8, 80).

% gana_bien(Persona)

gana_bien(Persona) :-
    asalariado(Persona, Horas, Sueldo),   %generador o data provider
    promedio(Horas, Prom),
    Sueldo > Prom.

gana_bien(Persona) :-
    jefe(Persona, Subordinados, Sueldo),
    length(Subordinados, Cantidad),
    Sueldo > 20 * Cantidad.

gana_bien(Persona) :-
    independiente(Persona, arquitecto, _).

gana_bien(Persona) :-
    independiente(Persona, Oficio, Sueldo),
    Oficio \= arquitecto,
    Sueldo > 70.

% paganini(Departamento)

paganini(Departamento) :-
    trabaja_en(_, Departamento),    %es un generador. es necesario para que entren de a uno el depto de las personas. el profe justifico que de esta forma no esta tan bueno el generador.
    forall(trabaja_en(Persona, Departamento), gana_bien(Persona)).

%de esta forma puede traer soluciones repetidas x el generador.

%otra forma es definir departamento previamente y hacer esta solucion;

%departamento(departamento):- distinct (departamento, trabaja(departamento, _))
 
% esPaganini(departamento):-
    departamento (departamento),    %predicado generador que no duplica departamentos. permite inversibilidad.

% si podes resolver con un unico not usas ese, pero en este caso es mas natural un forall. mas expresivo usarlo 1 vez.



%gana_bien (Persona):-
    gana(Persona, Sueldo),
    puesto(Persona, Puesto),
    criterioGanaBien(Sueldo, Puesto).

%criterioGanaBien(Sueldo, jefe(Empleados)):-
    length(Empleados, CantEmp),
    Sueldo > 20 * CantEmp.

criterioGanaBien(_, independiente(arq))

criterioGanaBien(Sueldo, independiente(Ocupacion)):-
    ocupacion=/ arquitecto,
    sueldo>70.

%hay como un chequeo para que no pase que tenga un gana bien y un no gana bien.


criterioGanaBien(sueldo, asalariado(horas)):-
    promedio(horas, SueldoPromedio),
    Sueldo > SueldoPromedio.


%Es mejor usar predicados mas cohesivos, que cada uno te de lo que necesitas. busco estar menos acoplado.

/*

Punto 3: Houston...
Sabemos en qué departamento le gusta trabajar a una persona.
A Kyle le gusta trabajar en Ventas o en Logística.
A Trisha y a Joshua le gusta trabajar en Ventas.
A Sherri le gusta trabajar en Contabilidad, pero también en Facturación y Cobranzas.

Queremos saber si un departamento está en problemas, esto ocurre si ninguna persona que trabaja en ese departamento quiere trabajar ahí.
Logística es un departamento que está en problemas. El predicado debe ser inversible.

*/

%Definir uno a uno y no usando una lista. SOLO usamos lista cuando queremos un orden , sino NO queremos usarla.

leGustaTrabajarEn(kyle, ventas).
leGustaTrabajarEn(kyle, logistica).     %%Si tengo un "o" lo defino en hechos aislados.
leGustaTrabajarEn(trisha, ventas)
leGustaTrabajarEn(joshua, ventas)
leGustaTrabajarEn(sherri, contabilidad)
leGustaTrabajarEn(sherri, facturacionYCobranzas)

estaEnProblemas (Departamento):-
    departamento (Departamento),
    forall (trabaja (Persona, Departamento) , not (leGustaTrabajar(Persona, Departamento))).    %la variable del forall no es departamento, entra ligada, el forall hace pregunta existencial sobre la persona
    %esa solucion no esta tan buena, la b es mejor
    %b) not ((trabaja(Persona, Departamento) , leGustaTrabajar(Persona,Departamento))). esta solucion es mejor.

%El generador lo vamos a usar siempre que usemos un predicado de orden superior.
%espiritualmente un forall es un not not, pensar previamente para que no me quede alguna cosa rara asi.

% un forall con un not adentro no es lo mas recomendable. buscar ahi un demorgan.
%Siempre el generador antes que el forall. pensar primero en si puedo resolverlo con not, sino ver forall.

/*
Punto 4: El juego de las sillas
Siempre es momento de reorganizaciones, queremos saber qué posiblilidades tenemos de rearmar un departamento en base a un presupuesto dado, 
donde queremos que por lo menos haya 2 personas. BONUS: que diga cuánta plata nos sobraría de ese presupuesto.

Por ejemplo, si hay que reorganizar con 150 $, podemos armar
un equipo con Kyle y Trisha, y nos queda 10
un equipo con Kyle y Joshua, y nos queda 45
un equipo con Kyle, Joshua e Ian, y nos queda 5
un equipo con Kyle e Ian, y nos queda 60
un equipo con Kyle, Ian y Sherri y no nos queda plata
etc.

*/

%explosion combinatoria. no bomba recursiva.


reorganizar (Presupuesto, Equipo, Resto):-
    findall(Persona , trabaja(_, Persona) , Personas),
    armarEquipo(Personas , Equipo),
    length(Equipo, Tamanio),
    Tamanio >=2,
    costoEquipo(Equipo, Costo),
    Presupuesto >= Costo,
    Resto is Presupusto - Costo.

armarEquipo([],[])                      %Caso base
armarEquipo([Persona! Equipo], [Otros]):-   %Me quedo con la cabeza de la primer persona del equipo y trabajo con el resto.
    armarEquipo (Equipos, Otros).

armarEquipo([_! Equipo], Otros):-
    armarEquipo (Equipo, Otros).


%Usar findall puede traer mucho overhead en armarEquipo pq ya la estuve recorriendo en reorganizar.
%Es mejor meter mas mano en armarequipo y separar en casos recursivos y queda con mas performance.

%Hay una algoritmia si o si en recursividad. No es todo tan expresivo y declarativo.




% La mejor onda es ir haciendo un enfoque top down, empiezo desde lo general a lo particular
% Onda tiro el nombre del predicado y desp veo que hago posta.

Termina ocurriendo generalmente que: para explosion necesito una lista, sino la genero usando findall.
Despues del findall es usar una recursion practica de manual
