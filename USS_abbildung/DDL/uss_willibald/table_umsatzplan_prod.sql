-- DROP TABLE uss_willibald.umsatzplan_prod;

CREATE TABLE uss_willibald.umsatzplan_prod (
	md_inserted_at timestamp default current_timestamp,
	_key_umsatzplan_prod varchar(128) NOT NULL,
	jahr numeric(5,0) ,
	quartal numeric(1),
	GEPLANTER_PRODUKT_UMSATZ numeric(5,0)
);