-- DROP TABLE uss_willibald.produkt;

CREATE TABLE uss_willibald.produkt (
	md_inserted_at timestamp default current_timestamp,
	_key_produkt int4 NOT NULL,
	produktid int4 NOT NULL,
	bezeichnung varchar(512) NOT NULL,
	umfang varchar(128) NOT NULL,
	typ int4 NOT NULL,
	preis numeric(5, 2) NOT NULL,
	pflanzort varchar(128) NOT NULL,
	pflanzabstand varchar(128) NOT NULL,
	kategorie varchar(128),
	oberkategorie varchar(128)
);