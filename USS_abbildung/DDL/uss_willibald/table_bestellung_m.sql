
-- DROP TABLE uss_willibald.bestellung_m;

CREATE TABLE uss_willibald.bestellung_m (
	md_inserted_at timestamp default current_timestamp,
	_key_bestellung_m numeric(20) NOT NULL,
	rabatt numeric(5, 2),
	rabattbetrag numeric(16, 2),
	mitgliedsbonus numeric(16,2),
	gesamtbetrag numeric(16,2),
	umsatzsteuer numeric(16,2)
);

alter table uss_willibald.bestellung_m add constraint PK_bestellung PRIMARY KEY(_key_bestellung_m);
--alter table uss_willibald.xxx_m add constraint PK_xxx PRIMARY KEY(_key_xxx_m);