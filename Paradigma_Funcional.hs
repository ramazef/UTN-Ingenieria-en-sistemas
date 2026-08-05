


--Si voy a modelar un tipo nuevo de dato, me conviene usar Data en lugar de tuplas. Me valgo de funciones y record syntax.

--La tupla es mas restrictiva si tiene menos de 2 datos, hasta 2 tiene sentido y usar funciones first y second.

--Evitar usar funciones lambda, son poco expresivas. Scope limitado.



FUNCIONES 

{-
=========================
GUIA RAPIDA - FUNCIONAL
=========================

-- OPERADORES IMPORTANTES

(.)     Composición de funciones
        (f . g) x = f (g x)

(:)     Agrega un elemento al principio de una lista
        1 : [2,3] = [1,2,3]

++      Une listas
        [1,2] ++ [3,4] = [1,2,3,4]

==      Igualdad

/=      Distinto

&&      AND

||      OR (cortocircuito)

not     Negación

------------------------------------------------------------

head :: [a] -> a
Recibe: Lista NO vacía
Devuelve: Primer elemento

head [4,5,6]
4

------------------------------------------------------------

tail :: [a] -> [a]
Recibe: Lista NO vacía
Devuelve: Cola de la lista

tail [4,5,6]
[5,6]

------------------------------------------------------------

length :: [a] -> Number
Recibe: Lista
Devuelve: Cantidad de elementos

length [1,2,3]
3

------------------------------------------------------------

null :: [a] -> Bool
Recibe: Lista
Devuelve: True si está vacía

null []
True

null [3]
False

------------------------------------------------------------

elem :: Eq a => a -> [a] -> Bool
Recibe: Elemento + Lista
Devuelve: True si pertenece

elem 3 [1,2,3]
True

------------------------------------------------------------

take :: Number -> [a] -> [a]
Recibe: Cantidad + Lista
Devuelve: Primeros N elementos

take 3 [1,2,3,4,5]
[1,2,3]

------------------------------------------------------------

drop :: Number -> [a] -> [a]
Recibe: Cantidad + Lista
Devuelve: Elimina los primeros N

drop 2 [1,2,3,4]
[3,4]

------------------------------------------------------------

sum :: [Number] -> Number
Recibe: Lista de números
Devuelve: Suma

sum [1,2,3]
6

------------------------------------------------------------

product :: [Number] -> Number
Recibe: Lista de números
Devuelve: Producto

product [2,3,4]
24

------------------------------------------------------------

maximum :: Ord a => [a] -> a
Recibe: Lista
Devuelve: Mayor elemento

maximum [3,8,2]
8

------------------------------------------------------------

minimum :: Ord a => [a] -> a
Recibe: Lista
Devuelve: Menor elemento

minimum [3,8,2]
2

------------------------------------------------------------

reverse :: [a] -> [a]
Recibe: Lista
Devuelve: Lista invertida

reverse [1,2,3]
[3,2,1]

------------------------------------------------------------

map :: (a -> b) -> [a] -> [b]
Recibe:
    Una función
    Una lista

Devuelve:
    Otra lista transformada

map (*2) [1,2,3]
[2,4,6]

map nombre personas
["Juan","Ana"]

------------------------------------------------------------

filter :: (a -> Bool) -> [a] -> [a]
Recibe:
    Una condición
    Una lista

Devuelve:
    Solo los elementos que cumplen

filter (>0) [-1,5,2,-3]
[5,2]

------------------------------------------------------------

all :: (a -> Bool) -> [a] -> Bool
True si TODOS cumplen

all (>0) [1,2,3]
True

------------------------------------------------------------

any :: (a -> Bool) -> [a] -> Bool
True si ALGUNO cumple

any (>5) [1,8,2]
True

------------------------------------------------------------

fst :: (a,b) -> a
Primer elemento de una tupla

fst ("Juan",20)
"Juan"

------------------------------------------------------------

snd :: (a,b) -> b
Segundo elemento de una tupla

snd ("Juan",20)
20

------------------------------------------------------------

APLICACION PARCIAL

(*2)

(+5)

(>18)

(=="Juan")

Todos devuelven una función.

------------------------------------------------------------

COMPOSICION

length . habilidades

head . fst

(== 'C') . head . nombre

(f . g) x = f (g x)

------------------------------------------------------------

PATRONES DE LISTAS

[]          Lista vacía

(x:xs)      Cabeza y cola

(x:y:ys)    Dos primeros y resto

------------------------------------------------------------

RECURSION SOBRE LISTAS

casoBase []

casoRecursivo (x:xs)

Ejemplo:

longitud [] = 0
longitud (x:xs) = 1 + longitud xs

------------------------------------------------------------

RECORDATORIO DE RECORD SYNTAX

data Persona = Persona {
    nombre :: String,
    edad :: Number
}

Genera automáticamente:

nombre :: Persona -> String

edad :: Persona -> Number

------------------------------------------------------------
}



=================================================   
FOLD                                                    quiero converger a un resultado
=================================================

foldl :: (b -> a -> b) -> b -> [a] -> b

Recibe:
    Función acumuladora
    Valor inicial
    Lista

Recorre de izquierda a derecha.

foldl (+) 0 [1,2,3]
6

Paso a paso:

(((0+1)+2)+3)

--------------------------------------------

foldr :: (a -> b -> b) -> b -> [a] -> b

Recibe:
    Función acumuladora
    Valor inicial
    Lista

Recorre de derecha a izquierda.

foldr (+) 0 [1,2,3]

1 + (2 + (3 + 0))

--------------------------------------------

¿Cuándo usar fold?

Cuando quiero obtener UN SOLO resultado
a partir de una lista.

Ejemplos:

sum
product
length
and
or
concat

Todos pueden implementarse con fold.

=================================================
EJEMPLOS CON FOLD
=================================================

Sumar

foldl (+) 0 [1,2,3]
6

--------------------------------------------

Multiplicar

foldl (*) 1 [2,3,4]
24

--------------------------------------------



Doc anterior:



--funcion que dice si el siguiente numero es par.

siguienteNum :: Number -> Number 
siguiente valor = valor + 1

esPar :: Number -> Bool 
esPar valor = ( even . siguienteNum ) valor 


--Saber si una persona es mayor a 18

type Persona = (String, Number) --Las tuplas agrupan elementos de distintos tipos

esMayor :: Persona -> Bool
esMayor persona = ((>18) . snd) persona

clara :: Persona
clara = ("Clara", 30)



--Saber si el nombre de una persona comienza con C

type Persona = (String, Number)

empiezaConLetraC :: Persona -> Bool
empiezaConLetraC persona = ((== 'C') . head . fst) persona

--Ejemplos aplicacion parcial. en ambos casos simplemente estoy definiendo multiplicar o mayor que, pasandoles 1 solo parametro .

--Mostrar el doble de los nums de una lista

map (*2) [1...8]

--Mostrar los mayores a 0

filter (>0) [5, -1, 4, 2, -4]

--Notacion record syntax

data Persona = Persona {                            --la estructura esta compuesta por funciones.
    fechaNacimiento :: (Number, Number, Number),
    edad :: Number,
    nombre :: String,
    buenaPersona :: Bool,
    telefono :: String,
    domicilio :: String,
    plata :: Number
}

juan :: Persona
juan = Persona {
    fechaNacimiento = (17,7,1988),
    edad = 29,
    nombre = "Juan",
    buenaPersona = True,
    telefono = "45232598",
    domicilio = "Ayacucho 554",
    plata = 30.0
} --deriving (show)  para mostrar valores del data x consola

--1_ Defino el data persona , 2_ Defino a una persona en concreto

--Si quiero hacer una modificacion sobre un parametro de una persona , por ejemplo cambiar la edad, lo hago asi 
--para evitar hacer un pattern matching con todos los atributos:

cumplirAnios :: Persona -> Persona           --por inmutabilidad del paradigma, necesito crear una nueva persona
cumplirAnios persona = persona {
    edad = edad persona +1 
    }


--Ejemplo recursividad factorial

factorial :: Number - Number
factorial numero                --lo que recibo
    |   numero == 0 = 1         --caso base
    |   numero >0 = numero * factorial (numero -1)  --caso recursivo. Obligatorio poner parentesis, sino saca factorial de num y le resta 1.
                                         --ojo con meter un otherwise pq admitiria ingresar un num negativo, daria stack overflow

--Otra forma sin guardas usando pattern matching
factorial 0 = 1
factorial n = n * factorial (n-1)




--Listas y recursividad van a ligarse mucho.


longitud :: [a] -> Number 
longitud [] = 0
longitud (x:xs) = 1 + longitud xs   

--recordar que si no tengo definido el tamanio de la lista uso parentesis


--hallar ultimo elemento

ultimo :: [a] -> a 
ultimo [x] = x  --caso base , devuelve exactamente un elemento. el caso base no es el ultimo de una lista vacia.
ultimo (x:xs) = ultimo xs    --me voy desprendiendo de la cabeza en el caso recursivo


--tomar los primeros N elementos de una lista

tomar :: Number -> [a] -> [a]
tomar 0 xs = []                 --caso base 1. por pattern matching agrego xs.



--Saber si un elemento esta en una lista

esta :: a -> [a] -> Bool  
esta elemento [] = False        --condicion de corte, no hay elemento alguno
esta elemento (x:xs) = elemento == x || esta elemento xs  --encuentra al elemento en la cabeza o lo va buscando en la cola de forma recursiva


--aca sin recursividad usando elem

esta :: Eq a => a -> [a] -> Bool
esta elemento lista = elem elemento lista
