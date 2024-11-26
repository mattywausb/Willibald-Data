
-- DROP TABLE uss_willibald.bridge_willibald

CREATE TABLE uss_willibald.bridge_willibald (
	md_inserted_at timestamp default current_timestamp
	,stage varchar(255) not null
	,_key_bestellung numeric(20)
	,_key_bestellung_m numeric(20)
	,_key_kunde varchar(13)
	,_key_lieferadresse numeric(10)
	,_key_lieferdienstid varchar(30)
	,_key_lieferung varchar(100)
	,_key_lieferung_m varchar(100)
	,_key_position varchar(100)
	,_key_position_m varchar(100)
	,_key_produkt numeric(10)
	,_key_produkt_m numeric(10)
	,_key_vereinspartner varchar(30)
);
