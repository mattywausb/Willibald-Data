
-- DROP TABLE uss_willibald.bestellung;

CREATE TABLE uss_willibald.bestellung (
	md_inserted_at timestamp default current_timestamp,
	_key_bestellung int8 NOT NULL,
	bestellungid int8 NOT NULL,
	bestelldatum date NOT NULL,
	wunschdatum date NOT NULL,
	rabatt numeric(5, 2) NOT NULL
);