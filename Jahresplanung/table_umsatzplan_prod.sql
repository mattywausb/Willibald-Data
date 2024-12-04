-- DROP TABLE jahresplanung.umsatzplan_prod;

CREATE TABLE jahresplanung.umsatzplan_prod (
	produktid numeric(20),
	jahr numeric(5,0) ,
	quartal numeric(1),
	GEPLANTER_PRODUKT_UMSATZ numeric(5,0)
);