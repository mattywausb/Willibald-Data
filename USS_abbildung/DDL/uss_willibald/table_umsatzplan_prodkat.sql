-- DROP TABLE uss_willibald.umsatzplan_prodkat;

CREATE TABLE uss_willibald.umsatzplan_prodkat (
	md_inserted_at timestamp default current_timestamp,
	_key_umsatzplan_prodkat varchar(128) NOT NULL,
	oberkategorie varchar(128) NOT NULL,
	jahr numeric(5,0) ,
	monat numeric (2),
	geplanter_kategorie_umsatz numeric(5,0)
);