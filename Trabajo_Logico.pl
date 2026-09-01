% ========================================================= %
%    TRABAJO PRACTICO PARADIGMA LOGICO: INMORTAL KOMBAT     %
% ========================================================= %


%%%% Punto 1. (Todo el grupo) Modelar los luchadores %%%%
% Forma del tipo de disciplina: disciplinaTipo(Disciplina, Tipo).
disciplinaTipo(jiujitsu, piso).
disciplinaTipo(sambo, piso).
disciplinaTipo(judo, piso).
disciplinaTipo(muaythai, parado).
disciplinaTipo(boxeo, parado).
disciplinaTipo(kickboxing, parado).

% Los luchadores son:
luchador(mora).
luchador(tomi).
luchador(vale).
luchador(mati).
luchador(facu).
luchador(fede).

% Forma de entrena: entrena(Luchador, Disciplina).
entrena(mora, jiujitsu).
entrena(mora, muaythai).
entrena(tomi, muaythai).
entrena(tomi, boxeo).
entrena(vale, judo).
entrena(vale, kickboxing).
entrena(mati, sambo).
entrena(facu, muaythai).
entrena(facu, boxeo).
entrena(facu, kickboxing).
% No es necesario definir que Fede no entrena ninguna disciplina por el principio de universo cerrado

% Cinturones (solo se otorgan con disciplinas de piso)
% cinturon(Luchador, Disciplina, Color).
cinturon(mora, jiujitsu, violeta).
cinturon(vale, judo, marron).
cinturon(mati, sambo, negro).

% Un luchador con cinturon violeta en Jiu Jitsu es equivalente a un cinturon negro en Judo 
% p => q , p=El luchador tiene cinturon violeta en Jiu Jitsu. q=El luchador es equivalente a cinturón negro en Judo.
% Q:-P
cinturon(Luchador, judo, negro) :- cinturon(Luchador, jiujitsu, violeta).

% sabeTecnica(Luchador, FunctorTecnica)
% Estructuras con efectividad integrada [2]:
% - dePiso(Nombre, Posicion, Segundos) 
% - golpe(Nombre, Zona, Potencia)
% - lance(Nombre, Categoria, Puntos)

% --- MORA --- [5, 6]
sabeTecnica(mora, dePiso(triangulo, guardia, 4)).
sabeTecnica(mora, dePiso(armlock, montada, 7)).
sabeTecnica(mora, golpe(rodillazo, cuerpo, 6)).
sabeTecnica(mora, golpe(patada, cabeza, 9)).

% --- TOMI --- [5, 6]
sabeTecnica(tomi, golpe(codazo, cabeza, 9)).
sabeTecnica(tomi, golpe(gancho, cabeza, 6)).
sabeTecnica(tomi, golpe(directo, cuerpo, 7)).
sabeTecnica(tomi, dePiso(mataleon, espalda, 8)).

% --- VALE --- [5, 6]
sabeTecnica(vale, dePiso(estrangulacion, espalda, 3)).
sabeTecnica(vale, golpe(patada, pierna, 7)).
sabeTecnica(vale, golpe(cruzado, cabeza, 9)).
sabeTecnica(vale, lance(o_soto_gari, proyeccion, 9)).
sabeTecnica(vale, lance(ippon_seoi_nage, tackle, 6)).

% --- MATI --- [5, 6]
sabeTecnica(mati, dePiso(botita, guardia, 3)).
sabeTecnica(mati, dePiso(triangulo, guardia, 4)).
sabeTecnica(mati, dePiso(mataleon, espalda, 5)).
sabeTecnica(mati, dePiso(llave_de_brazo, espalda, 2)).
sabeTecnica(mati, dePiso(llave_de_brazo, montada, 4)).
sabeTecnica(mati, dePiso(llave_de_rodilla, montada, 5)).

% --- FACU --- [5, 6]
sabeTecnica(facu, golpe(directo, cabeza, 9)).
sabeTecnica(facu, golpe(gancho, cabeza, 8)).
sabeTecnica(facu, golpe(patada, cabeza, 10)).




%%%% Punto 2. (integrante 1)  esFielASuDisciplina %%%%%

% tipoDeTecnica(Tecnica, Tipo)
tipoDeTecnica(dePiso(_, _, _), piso).
tipoDeTecnica(golpe(_, _, _), parado).
tipoDeTecnica(lance(_, _, _), parado).

% entrenaDisciplinaDeTipo(Luchador, Tipo)
entrenaDisciplinaDeTipo(Luchador, Tipo) :-
    entrena(Luchador, Disciplina),
    disciplinaTipo(Disciplina, Tipo).

% tecnicaRespaldadaPorDisciplina(Luchador, Tecnica)
tecnicaRespaldadaPorDisciplina(Luchador, Tecnica) :-
    tipoDeTecnica(Tecnica, Tipo),
    entrenaDisciplinaDeTipo(Luchador, Tipo).

esFielASuDisciplina(Luchador) :-
    luchador(Luchador),
    forall(sabeTecnica(Luchador, Tecnica),
           tecnicaRespaldadaPorDisciplina(Luchador, Tecnica)).




%%%%  Punto 3: esPicante - (Integrante 2)  %%%%
esPicante(Luchador) :-
    luchador(Luchador),
    entrenaParado(Luchador),
    not(entrenaPiso(Luchador)),
    forall(sabeTecnica(Luchador, Tecnica), esGolpeACabeza(Tecnica)).

entrenaParado(Luchador) :-
    entrena(Luchador, Disciplina), disciplinaTipo(Disciplina, parado).

entrenaPiso(Luchador) :-
    entrena(Luchador, Disciplina), disciplinaTipo(Disciplina, piso).

esGolpeACabeza(golpe(_, cabeza, _)).
   



%%%%%  Punto 4. (integrante 3) esNavajaSuiza/1 Misma tecnica en distintas posiciones. %%%%%
esNavajaSuiza(Luchador) :-
    luchador(Luchador), % Generador para asegurar la inversibilidad [9]
    cinturon(Luchador, _, negro), % Cinturón negro (directo o por equivalencia)
    sabeTecnica(Luchador, dePiso(Tecnica, Posicion1, _)), % Sabe una tecnica de piso
    sabeTecnica(Luchador, dePiso(Tecnica, Posicion2, _)), % Sabe la misma tecnica de piso en otra posicion
    Posicion1 \= Posicion2, % Las posiciones son distintas [10]
    not(sabeTecnica(Luchador, golpe(_, _, _))),  % No sabe ningún golpe [11]
    not((entrena(Luchador, Disciplina), disciplinaTipo(Disciplina, parado))). % No entrena disciplinas de parado [12]




%%%%%  Punto 5. (Todos los integrantes) %%%%%

% esContundente(Tecnica) [7]
% Un sometimiento (movimiento de piso) es contundente si tarda 5 segundos o menos
esContundente(dePiso(_, _, Segundos)) :- 
    Segundos =< 5.

% Un golpe es contundente si apunta a la cabeza y tiene potencia 8 o más
esContundente(golpe(_, cabeza, Potencia)) :- 
    Potencia >= 8.

% Un lance es contundente si otorga 8 puntos o más
esContundente(lance(_, _, Puntos)) :- 
    Puntos >= 8.




%%%%  Punto 6. (Integrante 1) tieneUnPuntoFlojo %%%% 

tieneUnPuntoFlojo(Luchador) :-
    sabeTecnica(Luchador, dePiso(Nombre, Posicion, Segundos)),
    not(esContundente(dePiso(Nombre, Posicion, Segundos))).




%%%%%  Punto 7: esCertero - (Integrante 2) %%%%
esCertero(Luchador) :- 
    luchador(Luchador),
    forall((sabeTecnica(Luchador, Tecnica), esContundente(Tecnica)) , tipoDeTecnica(Tecnica, parado)).
%



%%%%% Punto 8. (Integrante 3) esTemible/1 %%%%%
esTemible(Luchador) :- 
    luchador(Luchador), 
    forall(sabeTecnica(Luchador, Tecnica), esContundente(Tecnica)).
%



%%%% Punto 9: comboPosible - (Todos los integrantes) %%%%
% comboPosible relaciona (Luchador, CantMaxTecnicas, NumCombosPosibles)
% cantTecnicas va entre 0 y un numero maximo que resulta del calculo del numero combinatorio
% entre la cantidad de tecnicas que sabe y la cantidad max de tecnicas que admite
comboPosible(Luchador, CantMaxTecnicas, Combo) :-
    luchador(Luchador),
    findall(Tecnica, sabeTecnica(Luchador, Tecnica), Tecnicas),
    subconjunto(Tecnicas, Combo),
    length(Combo, Cantidad),
    Cantidad =< CantMaxTecnicas.

% subconjunto(Lista, Subconjunto)
% Caso base + dos casos recursivos: cada elemento entra o no entra.
subconjunto([], []).  %% Caso base
subconjunto([Tecnica|Tecnicas], [Tecnica|Combo]) :-
    subconjunto(Tecnicas, Combo).
subconjunto([ _ |Tecnicas], Combo) :-
    subconjunto(Tecnicas, Combo).





% =========================================== %
%                   TESTS                     %
% =========================================== %

:- begin_tests(inmortal_kombat).

% --- Pruebas de Punto 2: esFielASuDisciplina/1 ---

test(punto2_vale_es_fiel) :-
    esFielASuDisciplina(vale).
 
test(punto2_tomi_no_es_fiel, fail) :-
    esFielASuDisciplina(tomi).

test(punto2_luchadores_fieles_inversibilidad, set(Luchador == [mora, vale, mati, facu, fede])) :-
    esFielASuDisciplina(Luchador).


% --- Pruebas de Punto 3: esPicante --- %
test(punto3_facu_es_picante) :-
    esPicante(facu).

test(punto3_tomi_NO_es_picante, fail) :-
    esPicante(tomi).

test(punto3_luchadores_picantes, set(Luchador == [facu])) :-
    esPicante(Luchador).


% --- Pruebas de Punto 4: esNavajaSuiza/1 ---
test(mati_es_navaja_suiza) :-
    esNavajaSuiza(mati).

test(mora_no_es_navaja_suiza, fail) :-
    esNavajaSuiza(mora).

test(inversibilidad_navaja_suiza, set(Luchador == [mati])) :-
    esNavajaSuiza(Luchador).


% --- Pruebas de Punto 5: esContundente/1 ---
test(punto5_el_triangulo_de_mora_es_contundente) :-
    esContundente(dePiso(triangulo, guardia, 4)).

test(punto5_el_armlock_de_mora_NO_es_contundente, fail) :-
    esContundente(dePiso(armlock, montada, 7)).

test(punto5_la_patada_de_mora_es_contundente) :-
    esContundente(golpe(patada, cabeza, 9)).

test(punto5_el_rodillazo_de_mora_NO_es_contundente, fail) :-
    esContundente(golpe(rodillazo, cuerpo, 6)).

test(punto5_el_gancho_de_tomi_NO_es_contundente, fail) :-
    esContundente(golpe(gancho, cabeza, 6)).


test(punto5_el_o_soto_gari_de_vale_es_contundente) :-
    esContundente(lance(o_soto_gari, proyeccion, 9)).

test(punto5_el_ippon_seoi_nage_de_vale_NO_es_contundente, fail) :-
    esContundente(lance(ippon_seoi_nage, tackle, 6)).


% --- Pruebas de Punto 6: tieneUnPuntoFlojo/1 ---
test(punto6_mora_tiene_punto_flojo) :-
    tieneUnPuntoFlojo(mora).
 
test(punto6_tomi_tiene_punto_flojo) :-
    tieneUnPuntoFlojo(tomi).
 
test(punto6_vale_NO_tiene_punto_flojo, fail) :-
    tieneUnPuntoFlojo(vale).
 
test(punto6_mati_NO_tiene_punto_flojo, fail) :-
    tieneUnPuntoFlojo(mati).
 
% Facu falla por otro motivo: no sabe ningun sometimiento.
test(punto6_facu_NO_tiene_punto_flojo, fail) :-
    tieneUnPuntoFlojo(facu).
 
test(punto6_luchadores_que_tienen_un_punto_flojo, set(Luchador == [mora, tomi])) :-
    tieneUnPuntoFlojo(Luchador).


% --- Pruebas de Punto 7: esCertero ---
test(punto7_tomi_es_certero) :-
    esCertero(tomi).

test(punto7_facu_es_certero) :-
    esCertero(facu).

test(punto7_mora_NO_es_certero, fail) :-
    esCertero(mora).

test(punto7_vale_NO_es_certero, fail) :-
    esCertero(mora).

test(punto7_mati_NO_es_certero, fail) :-
    esCertero(mora).

test(punto7_luchadores_que_son_certeros, set(Luchador == [tomi, facu, fede])):-
    esCertero(Luchador).


% --- Punto 8: Pruebas de esTemible/1 ---
test(mati_es_temible) :-
    esTemible(mati).

test(facu_es_temible) :-
    esTemible(facu).

test(mora_no_es_temible, fail) :-
    esTemible(mora).

test(tomi_no_es_temible, fail) :-
    esTemible(tomi).

test(vale_no_es_temible, fail) :-
    esTemible(vale).

test(inversibilidad_temible, set(Luchador == [mati, facu, fede])) :-
    esTemible(Luchador).

% test punto 9

test(punto9_facu_tiene_4_combos_de_hasta_una_tecnica) :-
    findall(Combo, comboPosible(facu, 1, Combo), Combos),
    length(Combos, 4).

test(punto9_facu_tiene_7_combos_de_hasta_dos_tecnicas) :-
    findall(Combo, comboPosible(facu, 2, Combo), Combos),
    length(Combos, 7).

test(punto9_facu_tiene_8_combos_de_hasta_tres_tecnicas) :-
    findall(Combo, comboPosible(facu, 3, Combo), Combos),
    length(Combos, 8).

test(punto9_mati_tiene_22_combos_de_hasta_dos_tecnicas) :-
    findall(Combo, comboPosible(mati, 2, Combo), Combos),
    length(Combos, 22).

test(punto9_mati_con_maximo_cero_solo_el_combo_vacio, set(Combo == [[]])) :-
    comboPosible(mati, 0, Combo).

test(punto9_el_combo_vacio_siempre_es_posible) :-
    comboPosible(fede, 3, []).

test(punto9_facu_NO_puede_usar_tecnicas_ajenas, fail) :-
    comboPosible(facu, 2, [dePiso(botita, guardia, 3)]).

test(punto9_no_supera_el_maximo, fail) :-
    comboPosible(facu, 1, [golpe(directo, cabeza, 9), golpe(gancho, cabeza, 8)]).

test(punto9_luchadores_que_pueden_hacer_ese_combo, set(Luchador == [mora])) :-
    comboPosible(Luchador, 1, [golpe(patada, cabeza, 9)]).

test(punto9_combos_de_facu_de_hasta_una_tecnica_inversibilidad) :-
    findall(Combo, comboPosible(facu, 1, Combo), Combos),
    length(Combos, 4).

:- end_tests(inmortal_kombat).