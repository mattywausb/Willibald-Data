
-- DROP TABLE uss_willibald.bestellung_m;

CREATE TABLE uss_willibald.bestellung_m (
	md_inserted_at timestamp default current_timestamp,
	_key_bestellung_m numeric(20) NOT NULL,
	rabatt numeric(5, 2),
	rabattbetrag numeric(16, 2),
	mitgliedsbonus numeric(16,2),
	gesamtbetrag numeric(16,2),
	umsatzsteuernumber numeric(16,2)
);