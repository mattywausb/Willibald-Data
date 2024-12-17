
-- DROP TABLE dimensional_willibald.dim_bestellung;

CREATE TABLE dimensional_willibald.dim_bestellung (
	md_inserted_at timestamp default current_timestamp,
	_dk_bestellung numeric(20) NOT NULL,
	bestellungid numeric(20) NOT NULL,
	bestelldatum date NOT NULL,
	wunschdatum date NOT NULL,
	rabatt numeric(5, 2),
	rabattbetrag numeric(16, 2),
	mitgliedsbonus numeric(16,2),
	gesamtbetrag numeric(16,2),
	umsatzsteuer numeric(16,2)
);