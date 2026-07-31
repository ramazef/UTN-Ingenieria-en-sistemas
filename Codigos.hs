

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


