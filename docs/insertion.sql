-- Insertion plantilla ------------
-- INSERT INTO nombreTabla VALUES([NOMBREobjtype](VALORES,NOMBREoBJETO(VALORESS)));
-- Mapa ---------------------------

INSERT INTO mapa_table VALUES(	mapa_objtype(0,'Mina Rocosa'       ,10,'3vs3'         ,'atrapar gemas'));
INSERT INTO mapa_table VALUES(	mapa_objtype(1,'Cafeteria retro'   ,15,'3vs3'         ,'atrapar gemas'));
INSERT INTO mapa_table VALUES(	mapa_objtype(2,'Dos mil Lagos'     ,20,'supervivencia','quedar vivo'  ));
INSERT INTO mapa_table VALUES(	mapa_objtype(3,'Lagos ácidos'      ,14,'supervivencia','quedar vivo'  ));
INSERT INTO mapa_table VALUES(	mapa_objtype(4,'Presa Inundada'    ,13,'3vs3'         ,'atrapar gemas'));
INSERT INTO mapa_table VALUES(	mapa_objtype(5,'Muerte Desamparada',17,'supervivencia','quedar vivo'  ));

-- Apariencia ---------------------
INSERT INTO apariencia_table VALUES(	apariencia_objtype(0,'Shelly',0));
INSERT INTO apariencia_table VALUES(	apariencia_objtype(1,'Shelly PSG',29));
INSERT INTO apariencia_table VALUES(	apariencia_objtype(2,'El Primo',15));
INSERT INTO apariencia_table VALUES(	apariencia_objtype(3,'El Primo Rudo',45));

INSERT INTO apariencia_table VALUES(	apariencia_objtype(4,'Penny',20));
INSERT INTO apariencia_table VALUES(	apariencia_objtype(5,'Penny Coneja',100));
INSERT INTO apariencia_table VALUES(	apariencia_objtype(6,'Piper',150));
INSERT INTO apariencia_table VALUES(	apariencia_objtype(7,'Piper Colegiala',30));
INSERT INTO apariencia_table VALUES(	apariencia_objtype(8,'Tara',350));
INSERT INTO apariencia_table VALUES(	apariencia_objtype(9,'Tara Ninja',45));
INSERT INTO apariencia_table VALUES(	apariencia_objtype(10,'Leon',750));
INSERT INTO apariencia_table VALUES(	apariencia_objtype(11,'Leon Lobo',45));
INSERT INTO apariencia_table VALUES(	apariencia_objtype(12,'Toby Ruffs',72));
INSERT INTO apariencia_table VALUES(	apariencia_objtype(13,'Toby Ruffs Samurai',120));

-- Brawler ------------------------
-- Shelly,Brock
INSERT INTO brawler_table VALUES(	brawler_objtype(0,'Shelly',1,'recompensa de Trofeos',1,1,
	(SELECT REF(a_t) 
		FROM apariencia_table a_t 
		WHERE apariencia_id = 0)
	,3000,400)
);
-- El Primo, Poco
INSERT INTO brawler_table VALUES(	brawler_objtype(1,'El Primo',1,'Especial',1,1,
	(SELECT REF(a_t) 
		FROM apariencia_table a_t 
		WHERE apariencia_id = 2)
	,5000,300)
);
-- Rico , Penny
INSERT INTO brawler_table VALUES(	brawler_objtype(2,'Penny',1,'SuperEspecial',1,1,
	(SELECT REF(a_t) 
		FROM apariencia_table a_t 
		WHERE apariencia_id = 4)
	,3200,250)
);
-- Piper Edgar
INSERT INTO brawler_table VALUES(	brawler_objtype(3,'Piper',1,'Épico',1,1,
	(SELECT REF(a_t) 
		FROM apariencia_table a_t 
		WHERE apariencia_id = 6)
	,3000,999)
);
-- Byron Tara
INSERT INTO brawler_table VALUES(	brawler_objtype(4,'Tara',1,'Mítico',1,1,
	(SELECT REF(a_t) 
		FROM apariencia_table a_t 
		WHERE apariencia_id = 8)
	,4000,600)
);
-- Amber Leon
INSERT INTO brawler_table VALUES(	brawler_objtype(5,'Leon',1,'Legendario',1,1,
	(SELECT REF(a_t) 
		FROM apariencia_table a_t 
		WHERE apariencia_id = 10)
	,3200,650)
);
-- Toby Ruffs Surge
INSERT INTO brawler_table VALUES(	brawler_objtype(6,'Toby Ruffs',1,'Cromático',1,1,
	(SELECT REF(a_t) 
		FROM apariencia_table a_t 
		WHERE apariencia_id = 12)
	,3000,900)
);

-- Caja ---------------------------

-- Oferta -------------------------

-- Tienda -------------------------

-- Recompensa ---------------------

-- Pase de batalla ----------------

-- Camino de trofeos --------------

-- Cartera ------------------------

-- Compra -------------------------

-- Adquirir apariencia ------------

-- Jugador ------------------------

-- Utiliza ------------------------

-- Lucha --------------------------

-- Partida ------------------------

-- Juega Partida ------------------