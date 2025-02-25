-- DROP TABLE uss_willibald.produkt_m;

CREATE TABLE uss_willibald.produkt_m (
	md_inserted_at timestamp default current_timestamp,
	_key_produkt_m numeric(20) NOT NULL,
	werbebudget numeric(20)
);

alter table uss_willibald.produkt_m add constraint PK_produkt_m PRIMARY KEY(_key_produkt_m);