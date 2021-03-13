-- Drop Section
DROP TABLE juega_partida_table;
DROP TYPE juega_partida_objtype;
DROP TABLE partida_table;
DROP TYPE partida_objtype;
DROP TYPE lucha_objtype;
DROP TABLE jugador_table PURGE;
DROP TYPE jugador_objtype;
DROP TYPE adquirir_tabletype;
DROP TYPE adquirir_objtype;
DROP TYPE compra_tabletype;
DROP TYPE compra_objtype;
DROP TABLE cartera_table;
DROP TYPE cartera_objtype;
DROP TABLE camino_trofeos_table;
DROP TYPE camino_trofeos_objtype;
DROP TABLE pase_de_batalla_table;
DROP TYPE pase_de_batalla_objtype;
DROP TABLE recompensa_table;
DROP TYPE recompensa_objtype;
DROP TABLE tienda_table;
DROP TYPE tienda_objtype;
DROP TABLE oferta_table;
DROP TYPE oferta_objtype;
DROP TABLE caja_table;
DROP TYPE caja_objtype;
DROP TABLE brawler_table;
DROP TYPE brawler_objtype;
DROP TYPE apariencia_tabletype;
DROP TABLE apariencia_table;
DROP TYPE apariencia_objtype;
DROP TABLE mapa_table;
DROP TYPE mapa_objtype;
-------------------------------------------------
-- Mapa

CREATE OR REPLACE TYPE mapa_objtype AS OBJECT(
	mapa_id NUMBER(6),
	nombre VARCHAR(20),
	tamanno NUMBER(2), -- numero de celdas de alto y base
    tipo varchar(13),
    mecanica varchar(13)
);

CREATE TABLE mapa_table OF mapa_objtype(
	mapa_id PRIMARY KEY,
	nombre NOT NULL,
	CHECK(tamanno>=10),
	tipo CHECK(tipo in ('supervivencia','3vs3')),
	mecanica CHECK(mecanica in ('quedar vivo','atrapar gemas'))
);
-------------------------------------------------
-- Apariencia
CREATE OR REPLACE TYPE apariencia_objtype AS OBJECT(
	apariencia_id NUMBER(6),
	nombre VARCHAR(20),
	precio NUMBER(3)
);
CREATE TABLE apariencia_table OF apariencia_objtype(
	apariencia_id PRIMARY KEY,
	nombre NOT NULL,
	CHECK(0<=precio)
);
CREATE OR REPLACE TYPE apariencia_tabletype AS TABLE OF apariencia_objtype;
-------------------------------------------------
--Brawler

CREATE OR REPLACE TYPE brawler_objtype AS OBJECT(
	brawler_id NUMBER(6),
    nombre VARCHAR(10),
	nivel NUMBER(2),
	categoria VARCHAR(21),
	trofeos_actuales NUMBER(5),
	maximo_rango NUMBER(2),
	apariencia_activa REF apariencia_objtype,
	vida NUMBER(4),
	danno NUMBER(3)
);
CREATE TABLE brawler_table OF brawler_objtype(
	brawler_id PRIMARY KEY,
    nombre NOT NULL,
	CHECK(nivel>=1 AND nivel<=10),
	categoria CHECK(categoria in('recompensa de Trofeos','Especial','SuperEspecial','Épico','Mítico','Legendario','Cromático')),
	trofeos_actuales CHECK(trofeos_actuales>0),
	CHECK(maximo_rango >0),
	apariencia_activa SCOPE IS apariencia_table,
	CHECK(vida>1),
	CHECK(danno>1)
);

-- CREATE OR REPLACE TYPE brawler_tabletype AS TABLE OF brawler_objtype;
-------------------------------------------------
--Caja

CREATE OR REPLACE TYPE caja_objtype AS OBJECT(
	caja_id NUMBER(6),
	brawler REF brawler_objtype,
	oro NUMBER(3),
	tipo varchar(15)
);
CREATE TABLE caja_table OF caja_objtype(
	caja_id PRIMARY KEY,
	brawler SCOPE IS brawler_table,
	CHECK(oro>=20 AND oro<=500),
	tipo CHECK(tipo in ('Pequeña','Mediana','Grande'))
);
-------------------------------------------------
--Oferta

CREATE OR REPLACE TYPE oferta_objtype AS OBJECT(
	oferta_id NUMBER(6),
	tipo varchar(15),
	precio NUMBER(3),
	IVA NUMBER(2),
	-- las siguientes pueden ser nulas
	brawler REF brawler_objtype,
	apariencia REF apariencia_objtype,
	caja REF caja_objtype
);
CREATE TABLE oferta_table OF oferta_objtype(
	oferta_id PRIMARY KEY,
	tipo CHECK(tipo in('Brawler','Caja','Apariencia')),
	CHECK (precio>0),
	CHECK (IVA=21),
	-- las siguientes pueden ser nulas
	brawler SCOPE IS brawler_table,
	apariencia SCOPE IS apariencia_table,
	caja SCOPE IS caja_table
);

-------------------------------------------------
--Tienda

CREATE OR REPLACE TYPE tienda_objtype AS OBJECT(
	tienda_id NUMBER(6),
	fecha DATE,
	oferta_brawler REF oferta_objtype,
    oferta_caja REF oferta_objtype,
    oferta_random REF oferta_objtype
);
CREATE TABLE tienda_table OF tienda_objtype(
	tienda_id PRIMARY KEY,
	fecha NOT NULL,
	oferta_brawler SCOPE IS oferta_table,
    oferta_caja SCOPE IS oferta_table,
    oferta_random SCOPE IS oferta_table
);
-------------------------------------------------
-- Recompensa

CREATE OR REPLACE TYPE recompensa_objtype AS OBJECT(
	recompensa_id NUMBER(6),
	oro NUMBER(4),
	cajas REF caja_objtype
);

CREATE TABLE recompensa_table OF recompensa_objtype(
	recompensa_id PRIMARY KEY,
	CHECK(oro = 1000 OR oro = 500),
	cajas SCOPE IS caja_table
);
-------------------------------------------------
--Pase de batalla
CREATE OR REPLACE TYPE pase_de_batalla_objtype AS OBJECT(
	pase_id NUMBER(6),
	nivel NUMBER(2),
	recompensa REF recompensa_objtype
);
CREATE TABLE pase_de_batalla_table OF pase_de_batalla_objtype(
	pase_id PRIMARY KEY,
	CHECK(nivel>0 AND nivel<=70),
	recompensa SCOPE IS recompensa_table
);
-------------------------------------------------
-- Camino de trofeos
create or replace TYPE camino_trofeos_objtype AS OBJECT(
	camino_id NUMBER(6),
	nivel NUMBER(2),
	trofeos_actuales NUMBER(6), -- Sum del los actuaels del brawler
	maximo_trofeos NUMBER(6), -- sum max de los trofeos se actualiza solo si  se supera el maximo
	recompensa REF recompensa_objtype
);
CREATE TABLE camino_trofeos_table OF camino_trofeos_objtype(
	PRIMARY KEY(camino_id,nivel),
	CHECK(nivel>0 AND nivel<=100),
	CHECK(trofeos_actuales>=0), -- Sum del los actuaels del brawler
	CHECK(maximo_trofeos>=0), -- sum max de los trofeos se actualiza solo si  se supera el maximo
	recompensa SCOPE IS recompensa_table
);
-------------------------------------------------
--Cartera
CREATE OR REPLACE TYPE cartera_objtype AS OBJECT(
	cartera_id NUMBER(6),
	oro NUMBER(7),
	gemas NUMBER(5),
	puntosEstelares NUMBER(7),
	fichas NUMBER(7)
);
CREATE TABLE cartera_table OF cartera_objtype(
	cartera_id PRIMARY KEY,
	CHECK(0<=oro),
	CHECK(0<=gemas),
	CHECK(0<=puntosEstelares),
	CHECK(0<=fichas)
);
-------------------------------------------------
--Compra

CREATE OR REPLACE TYPE compra_objtype AS OBJECT(
	compra_id NUMBER(6),
	fecha DATE,
	precio NUMBER(3),
	concepto VARCHAR(255),
	oferta REF oferta_objtype
);
CREATE OR REPLACE TYPE compra_tabletype AS Table OF compra_objtype;


-------------------------------------------------
--Adquirir apariencia

CREATE OR REPLACE TYPE adquirir_objtype AS OBJECT(
	adquirir_id NUMBER(6),
	apariencia REF apariencia_objtype,
	brawler REF brawler_objtype
);
CREATE OR REPLACE TYPE adquirir_tabletype AS TABLE OF adquirir_objtype;
-------------------------------------------------
--Jugador

CREATE OR REPLACE TYPE jugador_objtype AS OBJECT(
	jugador_id NUMBER(6),
	nombre VARCHAR(20),
	nivel NUMBER(3),
	experiencia NUMBER(5),
	jugador_codigo NUMBER(6),
	victorias NUMBER(6),
	derrotas NUMBER(6),
	cartera REF cartera_objtype,
	tienda REF tienda_objtype,
	compra_realizada compra_tabletype,
	apariencia_adquirida adquirir_tabletype
	-- ESTE NTABLE ES PARA QUE SE INDIQUE QUE APARIENCIAS TIENE COMPRADAS EL JUGADOR
);

CREATE TABLE jugador_table OF jugador_objtype(
	jugador_id PRIMARY KEY,
	nombre NOT NULL,
	CHECK(nivel>=0),
	CHECK(0<=experiencia AND (nivel*100)>experiencia),
	jugador_codigo NOT NULL,
	CHECK(0<=victorias),
	CHECK(0<=derrotas),
	cartera SCOPE IS cartera_table,
	tienda SCOPE IS tienda_table)
    NESTED TABLE compra_realizada STORE AS compra_Ntable((PRIMARY KEY(NESTED_TABLE_ID,compra_id),
		fecha NOT NULL,
		CHECK(0<=precio),
		concepto NOT NULL
	))
	NESTED TABLE apariencia_adquirida STORE AS apariencia_Ntable((PRIMARY KEY(NESTED_TABLE_ID,adquirir_id)));

 ALTER TABLE compra_Ntable ADD(SCOPE FOR(oferta) IS oferta_table);
 ALTER TABLE apariencia_Ntable ADD(SCOPE FOR(brawler) IS brawler_table);
 ALTER TABLE apariencia_Ntable ADD(SCOPE FOR(apariencia) IS apariencia_table);
-------------------------------------------------
--Utiliza
CREATE OR REPLACE TYPE utiliza_objtype AS OBJECT(
	utiliza_id NUMBER(6),
	grupo NUMBER(1),
	brawler REF brawler_objtype,
	jugador REF jugador_objtype
);
-------------------------------------------------
-- Lucha

CREATE OR REPLACE TYPE lucha_objtype AS OBJECT(
	lucha_id NUMBER(6),
	brawler_jugador1 REF brawler_objtype,
	brawler_jugador2 REF brawler_objtype,
	vida_jugador1 NUMBER(5),
	vida_jugador2 NUMBER(5),
	danno_jugador1 NUMBER(5),
	danno_jugador2 NUMBER(5)
);

-------------------------------------------------
CREATE OR REPLACE TYPE utiliza_tabletype AS TABLE OF utiliza_objtype;
-------------------------------------------------
CREATE OR REPLACE TYPE lucha_tabletype AS TABLE OF lucha_objtype;
-------------------------------------------------
--Partida
CREATE OR REPLACE TYPE partida_objtype AS OBJECT(
	partida_id NUMBER(6),
	tipo_partida VARCHAR(13),
	utilizando utiliza_tabletype,
	luchas lucha_tabletype
);
CREATE TABLE partida_table OF partida_objtype(
	partida_id PRIMARY KEY,
	tipo_partida CHECK(tipo_partida in ('supervivencia','3vs3'))
    )
	NESTED TABLE utilizando STORE AS utilizando_Ntable((PRIMARY KEY(NESTED_TABLE_ID,utiliza_id),
		grupo CHECK(0<grupo AND grupo<10)
	)),
	NESTED TABLE luchas STORE AS luchas_Ntable((PRIMARY KEY(NESTED_TABLE_ID,lucha_id),
		CHECK(0<=vida_jugador1),
		CHECK(0<=vida_jugador2 ),
		CHECK(0<=danno_jugador1),
		CHECK(0<=danno_jugador2)
	));
ALTER TABLE utilizando_Ntable ADD(SCOPE FOR(brawler) IS brawler_table);
ALTER TABLE utilizando_Ntable ADD(SCOPE FOR(jugador) IS jugador_table);

ALTER TABLE luchas_Ntable ADD(SCOPE FOR(brawler_jugador1) IS brawler_table);
ALTER TABLE luchas_Ntable ADD(SCOPE FOR(brawler_jugador2) IS brawler_table);
-------------------------------------------------
--Juega Partida

CREATE OR REPLACE TYPE juega_partida_objtype AS OBJECT(
	jp_id NUMBER(6),
	resultado varchar(7),
	fichas_obtenidas NUMBER(2),
	trofeos_obtenidos NUMBER(2),
	partida REF partida_objtype,
	jugador REF jugador_objtype
);

CREATE TABLE juega_partida_table OF juega_partida_objtype(
	jp_id PRIMARY KEY,
	resultado CHECK( resultado in('Victoria','Derrota')),
	CHECK(fichas_obtenidas>=0 OR fichas_obtenidas<=40),
	CHECK(trofeos_obtenidos>=0 OR trofeos_obtenidos<=10),
	partida SCOPE IS partida_table,
	jugador SCOPE IS jugador_table
);
-------------------------------------------------
