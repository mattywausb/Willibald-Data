-- DROP TABLE jahresplanung.umsatzplan_prodkat;

CREATE TABLE jahresplanung.umsatzplan_prodkat (
	oberkategorie varchar(128) NOT NULL,
	jahr numeric(5,0) ,
	monat numeric(2),
	geplanter_kategorie_umsatz numeric(16,0)
);