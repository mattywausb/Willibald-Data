
-- DROP TABLE uss_willibald.Lieferung_m;

CREATE TABLE uss_willibald.Lieferung_m (
	md_inserted_at timestamp default current_timestamp,
	_key_lieferung_m varchar(100) NOT NULL,
    Lieferkosten numeric(20,2)
);

alter table uss_willibald.Lieferung_m add constraint PK_Lieferung_m PRIMARY KEY(_key_Lieferung_m);


