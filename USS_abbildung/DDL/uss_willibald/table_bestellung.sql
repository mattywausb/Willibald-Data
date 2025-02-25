
-- DROP TABLE uss_willibald.bestellung;

CREATE TABLE uss_willibald.bestellung (
	md_inserted_at timestamp default current_timestamp,
	_key_bestellung numeric(20) NOT NULL,
	bestellungid numeric(20) NOT NULL,
	bestelldatum date NOT NULL,
	wunschdatum date NOT NULL,
	rabatt numeric(5,2)
);

alter table uss_willibald.bestellung add constraint PK_bestellung PRIMARY KEY(_key_bestellung);
--alter table uss_willibald.xxx add constraint PK_xxx PRIMARY KEY(_key_xxx);