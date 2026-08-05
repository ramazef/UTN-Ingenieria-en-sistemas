
{-
Parcial Funcional 2026 — Meeseeks destructores
Tema 2

"I'm Mr. Meeseeks! Look at me!"

Rick le regaló a la familia Smith una Caja de Meeseeks: un dispositivo que, al apretar el botón, hace aparecer un Mr. Meeseeks 
con la tarea que se le pida.

Los Meeseeks existen para servir: aparecen, cumplen su tarea y desaparecen. 
Si la tarea se demora, sufren cada vez más, se vuelven más oscuros y peligrosos.

De cada Meeseeks conocemos:

su nombre (siempre arranca con "Mr. Meeseeks", pero puede recibir sufijos),
el color, que va del más claro al más oscuro: "celeste", "azul", "violeta", "negro",
las horas de existencia que lleva activo (un número),
la tarea actual que está intentando cumplir,
el historial de intentos: una colección de intentos, donde cada intento tiene una descripción de la tarea 
y la cantidad de horas que le tomó.

Una caja es un conjunto de Meeseeks.
-}

{-
Punto 1: I'm Mr. Meeseeks! (3 puntos)
a) Modelar los Meeseeks
Según lo indicado en la introducción. Adicionalmente, se pide modelar un Meeseeks de ejemplo.
-}

data Meeseek = Meeseek {
    nombre :: String,
    color :: String,
    horasVivo :: Number,
    tareaActual :: String,
    historialIntentos :: [Intento]
}

data Intento = Intento {
    descripcionTarea :: String,
    horasTomadas :: Number 
}

type Caja = ([Meeseek])

meesekEjemplo :: Meeseek 
meeseekEjemplo = Meeseek {                 --La variable debe llamarse igual que declaraste
    nombre = "Mr. Meeseeks Messi",          --Incluir el Mr. y siempre strings con comillas.
    color = "azul",
    horasVivo = 44,
    tareaActual = "respirar",
    historialIntentos = []  --elegi una lista vacia por simplicidad
}

{-
b) Color que merece
Queremos saber el color que le corresponde a un Meeseeks según sus horas de existencia:

Si lleva menos de 2 horas y su historial está vacío (nunca intentó nada), le corresponde "celeste".
Si lleva hasta 6 horas (inclusive), le corresponde "azul".
Si lleva más de 6 y hasta 20 horas y la cantidad de horas es par, le corresponde "violeta".
En cualquier otro caso, le corresponde "negro" (entró en pánico existencial).
-}

colorQueMerece :: Meeseek -> String  --Me interesa devolver solo el color, no un meeseek modificado. 
colorQueMerece meeseek
    | ((<2).horasVivo) meeseek && ((==0).length.historialIntentos) meeseek = "celeste"  
    | ((<=6).horasVivo) meeseek = "azul"    --pq va puntito? si no compongo nada y no es una funcion <=6
    | ((>6).horasVivo) meeseek && ((<=20).horasVivo) meeseek && (even . horasVivo) meeseek = "violeta"    --no uso un parentesis que englobe las 2 condiciones.
    --no puedo hacer un solo acceso al meeseek para fijar el rango, tengo que hacerlo en 2 tiempos.
    | otherwise  = "negro"   --no necesita recibir un meeseek                           

--en ningun momento asigno el color, yo lo que hago es devolver una palabra en base a una condicion


c) ¿Está sufriendo?

Queremos saber si un Meeseeks está sufriendo, lo cual ocurre si su color actual
no coincide con el color que le corresponde según sus horas de existencia, 
o si alguna vez intentó la tarea "explicar matemática" (figura tal cual en su historial de intentos). 
Los Meeseeks quedan traumatizados de por vida si tuvieran que explicar matemática.

estaSufriendo :: String -> Meeseek -> Bool 
estaSufriendo colorActual meeseek = 

    || elem ("explicar matematica") historialIntentos













-}



{-

-}



{-

-}



{-

-}



{-

-}


{-

-}