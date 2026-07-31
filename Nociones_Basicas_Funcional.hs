


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