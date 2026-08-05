
{-
En una granja viven animales, de los cuales registramos su nombre, el tipo de animal, el
peso, la edad y sabemos si está enfermo, lo cual podrá requerir una visita médica de
alguna persona veterinaria, que diagnostica los días de recuperación y le cobra un costo
por la atención.

Punto 1.1: Animales sueltos (3 puntos)
La pasó mal
Queremos saber si un animal la pasó mal, esto implica que alguna de las visitas
médicas que le hicieron le implicó más de 30 días de recuperación.

-}

data Animal = Animal {
nombre :: String,
tipoAnimal :: String,
peso :: Number,
edad :: Number,
estaEnfermo :: Bool,
visitasMedicas :: [Visita]  
}

data Visita = Visita {
diasDeRecuperacion :: Number,
costoConsulta :: Number  
}

--Lo modelo asi sabiendo que un animal puede tener varias visitas osea una lista.
--Ademas la visita por si sola tiene info util por eso la modelo con un data.

--1

laPasoMal :: Animal -> Bool
laPasoMal animal =
    any ((>30) . diasDeRecuperacion) (visitasMedicas animal)


{-
Punto 1.2 Nombre falopa
Queremos saber si un animal tiene un nombre falopa, esto pasa si la última letra
termina en 'i'. Por ejemplo, "gachi" o "pachi" además de ser de sagitario, tienen un
nombre falopa. "Dorothy" no tiene un nombre falopa.
En este punto no puede utilizar funciones auxiliares ni recursividad, solo
composición y aplicación parcial.
-}

--Un string es sinonimo de un vector de char, osea que "gachi" es tambien ['g','a','c','h','i']
--Por lo que puedo usar patrones de listas y la funcion last.

{- internamente la composicion esta haciendo esto. 

nombre :: Animal -> String
last :: String -> Char
(== 'i') :: Char -> Bool

-}

nombreFalopa :: Animal -> Bool     
nombreFalopa animal = ((== 'i') . last . nombre) animal


--incorrecto. yo puse el last afuera pq pense q se comportaba como any que iba afuera
--La diferencia está en que any es una función de orden superior que recibe dos parámetros, mientras que last no.
nombreFalopa animal = last ( (=='i')  . nombre ) animal 


{-
Punto 2: Actividades (4 puntos) Queremos modelar las actividades que se hacen en la granja, entre las cuales están
Engorde
Le dan de comer al animal "x" kilos de alimento balanceado, con lo cual incrementan la
mitad de su peso hasta un máximo de 5 kilos. Por ejemplo: si a la vaca Dorothy que
pesa 690 kilos le damos de comer 12 kilos de alimento balanceado, pasará a pesar 695
kilos. Si le damos 4 kilos, pesará 692.

Revisación
Si el animal está enfermo, se le registra una visita médica anotando los días de
recuperación y el costo. Además, al darle vitaminas, eso equivaldría a que el animal
coma 2 kilos de alimento balanceado. Consejo: evite repetir ideas.

Festejo cumple
Le agrega un año más y también se le hace una fiestita, por la emoción el animal pierde
un kilo.

Chequeo de peso
Queremos registrar si un animal está bien de peso, para lo cual tiene que estar por
arriba de un peso "x", en caso contrario el animal debe quedar enfermo.

-}

engorde :: Number -> Animal -> Animal
engorde kilos animal = animal { 
    peso = peso animal + min 5 (kilos / 2)
}


revision :: Number -> Number -> Animal -> Animal
revision dias costo animal
    | estaEnfermo animal = engorde 2 (animal {
        visitasMedicas = Visita dias costo : visitasMedicas animal
      })
    | otherwise = animal


festejoCumple :: Animal -> Animal 
festejoCumple animal = animal { 
edad = edad animal + 1,
peso= peso animal - 1
}



chequeoDePeso :: Number -> Animal -> Animal
chequeoDePeso pesoMinimo animal
    | peso animal <= pesoMinimo = animal {
        estaEnfermo = True
    }
    | otherwise = animal





{- 
Punto 3: El proceso (3 puntos)
Queremos modelar un proceso, que realiza una serie de actividades sobre un animal.
Se pide que además muestre un ejemplo de cómo podría evaluar por consola el
proceso para cada una de las actividades resueltas en el punto anterior.
En este punto no puede utilizar funciones auxiliares ni recursividad, solo
composición y aplicación parcial.
-}

--Un proceso es simplemente una secuencia de actividades. Actividades del punto anterior.

type Actividad = Animal -> Animal

type Proceso = [Actividad]

realizarProceso :: Proceso -> Animal -> Animal
realizarProceso proceso animal =
    foldl (\animal actividad -> actividad animal) animal proceso

--foldl sirve para ir acumulando un resultado. El acumulador va a ser el animal.


{-
Punto 4: ¿Mejora o no mejora? (2 puntos)
Dado un proceso (lista de actividades) y un animal, queremos saber si el animal mejora
sustentablemente el peso, esto implica que el peso nunca debe bajar de una actividad a
otra y tampoco debe subir más de 3 kilos de una actividad.
Este punto debe resolverlo con recursividad.

-}



{-
Punto 5: Give me one, give me two... (2 puntos)
a. Queremos obtener los primeros tres animales que tengan un nombre falopa.
Resolverlo solo con funciones de orden superior.
b. Si le pasáramos una cantidad infinita de animales, sería posible obtener un valor
computable para la función del punto anterior? Justifique su respuesta
relacionándolo con un concepto visto en la materia.
-}

primerosTresFalopa :: [Animal] -> [Animal]
primerosTresFalopa = take 3 . filter nombreFalopa


--b
Sí, es computable debido a la evaluación diferida (Lazy Evaluation). La función take 3 solo necesita los tres primeros animales 
que cumplan la condición, por lo que Haskell evalúa la lista de manera perezosa y no recorre la lista infinita completa.