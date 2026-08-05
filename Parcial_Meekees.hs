module Library where
import PdePreludat


data Meeseek = Meeseek{
    nombre :: String, 
    color :: String, 
    hsExistencia :: Number,
    tarea :: String,
    historialIntentos :: [Intento]
}
type Caja = [Meeseek]
data Intento = Intento{
    descripcion :: String, 
    horasQtardo :: Number
}

colorQueMerece :: Meeseek -> String
colorQueMerece meesek 
    | (null. historialIntentos $ meesek) && ((<2). hsExistencia $ meesek) =  "celeste"
    | (<=6). hsExistencia $ meesek = "azul"
    | ((<20). hsExistencia $ meesek) && even. hsExistencia $ meesek = "violeta"
    | otherwise = "negro"

estaSufriendo :: Meeseek -> Bool
estaSufriendo meesek = ( any(== "explicar matematica" ). map descripcion. historialIntentos $ meesek) || (color meesek /= colorQueMerece meesek )

esCajaAgotadora :: Caja -> Number -> Bool
esCajaAgotadora caja horasEsperadas = all (any ((==horasEsperadas). hsExistencia || (==0).length) historialIntentos) caja

hsDesperdiciadas :: Meeseek -> Number
hsDesperdiciadas meesek = sum. map horasQtardo. filter (estaSufriendo) meesek

agregarPrefijoOsufijo :: Meeseek -> ([a]->[a]) -> Meeseek
agregarPrefijoOsufijo meesek operacion = meesek{ nombre = operacion. nombre $ meesek }

modificarExistencia :: Meeseek -> (Number->Number) -> Meeseek
modificarExistencia meesek operacion = meesek{hsExistencia = max 0. operacion. hsExistencia $ meesek }

felicitar :: Meeseek -> Meeseek
felicitar meesek = agregarPrefijoOsufijo meesek (: "Feliz "). modificarExistencia (sutract 1) $ meesek

asustar :: Meeseek -> Meeseek
asustar meesek = agregarPrefijoOsufijo meesek (++ ["Feliz "]). modificarExistencia (+1) $ meesek