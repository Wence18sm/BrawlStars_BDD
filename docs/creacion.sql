CREATE OR REPLACE TYPE mapa_objtype AS OBJECT(
	mapa_id NUMBER(6),
	nombre VARCHAR(20),
	tamanno NUMBER(2), -- numero de celdas de alto y base
	tipo ENUM('supervivencia','3vs3'),
	mecanica ENUM('quedarVivo','AtrapaGema')
);


CREATE OR REPLACE TYPE apariencia_objtype AS OBJECT(
	apariencia_id NUMBER(6),
	nombre VARCHAR(20),
	precio NUMBER(3)
);
CREATE OR REPLACE TYPE apariencia_tabletype AS TABLE OF apariencia_objtype;
CREATE OR REPLACE TYPE brawler_objtype AS OBJECT(
	brawler_id NUMBER(6),
	nivel NUMBER(2), -- Constraint 1 a 10,
	categoria ENUM('común','Super Especial','Epico',
		'Especial','Mitico','legendario','Chromatico'),
	trofeos_actuales NUMBER(5),
	maximo_rango NUMBER(2),
	apariencia apariencia_objtype,
	lista_apariencias apariencia_tabletype,
	vida NUMBER(4),
	danno NUMBER(3)
);

CREATE OR REPLACE TYPE brawler_tabletype AS TABLE OF brawler_objtype;
CREATE OR REPLACE TYPE caja_objtype AS OBJECT(
	caja_id NUMBER(6),
	brawler brawler_tabletype,
	oro NUMBER(3),
	tipo ENUM('caja pequeña','caja mediana', 'caja grande'),
);

CREATE OR REPLACE TYPE oferta_objtype AS OBJECT(
	oferta_id NUMBER(6),
	tipo ENUM('caja pequeña','caja mediana', 'caja grande', 'brawler','apariencia'),
	precio NUMBER(3),
	IVA NUMBER(2),
	-- las siguientes pueden ser nulas
	brawler brawler_objtype,
	apariencia apariencia_objtype,
	caja caja_objtype
);
CREATE OR REPLACE TYPE oferta_tabletype AS TABLE OF oferta_objtype;
CREATE OR REPLACE TYPE tienda_objtype(
	tienda_id NUMBER(6),
	fecha DATE,
	lista_ofertas oferta_tabletype
);

CREATE OR REPLACE TYPE recompensa_objtype AS OBJECT(
	recompensa_id NUMBER(6),
	oro NUMBER(4),
	cajas caja_objtype
);
CREATE OR REPLACE TYPE recompensa_tabletype AS recompensa_objtype;

CREATE OR REPLACE TYPE pase_de_batalla_objtype AS OBJECT(
	pase_id NUMBER(6),
	nivel NUMBER(2),
	recompensa recompensa_tabletype
);
CREATE OR REPLACE TYPE camino_trofeos_objtype AS OBJECT(
	camino_id NUMBER(6),
	nivel NUMBER(2),
	trofeos_actuales NUMBER(6), -- Sum del los actuaels del brawler
	maximo_trofeos NUMBER(6), -- sum max de los trofeos se actualiza solo si  se supera el maximo
	recompensa recompensa_tabletype
);
CREATE OR REPLACE TYPE cartera_objtype AS OBJECT(
	cartera_id NUMBER(6),
	oro NUMBER(7),
	gemas NUMBER(5),
	puntosEstelares NUMBER(7),
	fichas NUMBER(7)
);
CREATE OR REPLACE TYPE compra_objtype AS OBJECT(
	compra_id NUMBER(6),
	fecha DATE,
	precio NUMBER(3),
	concepto VARCHAR(255)
);
CREATE OR REPLACE TYPE compra_tabletype AS compra_objtype;

CREATE OR REPLACE TYPE jugador_objtype AS OBJECT(
	jugador_id NUMBER(6),
	nombre VARCHAR(20),
	experiencia NUMBER(5),
	nivel NUMBER(3),
	jugador_codigo NUMBER(6),
	victorias NUMBER(6),
	derrotas NUMBER(6),
	cartera cartera_objtype,
	tienda tienda_objtype,
	comprasRealizadas compra_tabletype
);

CREATE OR REPLACE TYPE utiliza_objtype AS OBJECT(
	utiliza_id NUMBER(6),
	grupo NUMBER(1),
	brawler brawler_objtype,
	jugador jugador_objtype
);
CREATE OR REPLACE TYPE lucha_objtype AS OBJECT(
	lucha_id NUMBER(6),
	brawler_jugador2 brawler_tabletype,
	vida_jugador1 NUMBER(5),
	vida_jugador2 NUMBER(5),
	danno_jugador1 NUMBER(5),
	danno_jugador2 NUMBER(5)
);

CREATE OR REPLACE TYPE utiliza_tabletype AS TABLE OF utiliza_objtype;
CREATE OR REPLACE TYPE lucha_tabletype AS TABLE OF lucha_objtype;



CREATE OR REPLACE TYPE partida_objtype AS OBJECT(
	partida_id NUMBER(6),
	tipo_partida EMUN('supervivencia','3vs3'),
	utilizando utiliza_tabletype,
	luchas luchas_tabletype
);

CREATE OR REPLACE TYPE juega_partida_objtype AS OBJECT(
	jp_id NUMBER(6),
	resultado ENUM('Victoria','Derrota'),
	fichas_obtenidas NUMBER(2),
	trofeos_obtenidos NUMBER(2),
	partida partida_objtype,
	jugador jugador_objtype
);
