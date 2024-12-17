-- DROP TABLE DIMENSIONAL_WILLIBALD.dim_produkt;

CREATE TABLE DIMENSIONAL_WILLIBALD.dim_produkt (
	md_inserted_at timestamp default current_timestamp,
	_dk_produkt numeric(20) NOT NULL,
	produktid numeric(20) NOT NULL,
	bezeichnung varchar(512) NOT NULL,
	umfang varchar(128) NOT NULL,
	pflanztyp varchar(128) NOT NULL,
	preis numeric(5, 2) NOT NULL,
	pflanzort varchar(128) NOT NULL,
	pflanzabstand varchar(128) NOT NULL,
	kategorie varchar(128),
	Zehrgruppe varchar(128),
	oberkategorie varchar(128),
	werbebudget numeric(20)
);