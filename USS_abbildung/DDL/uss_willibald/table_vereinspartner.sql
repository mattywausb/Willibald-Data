-- DROP TABLE uss_willibald.vereinspartner;

CREATE TABLE uss_willibald.vereinspartner (
	md_inserted_at timestamp default current_timestamp,
	_key_vereinspartner  varchar(30) NOT NULL,
	VEREINSPARTNERID VARCHAR(30) NOT NULL,
	RABATT1 NUMERIC(38,0),
	RABATT2 NUMERIC(38,0),
	RABATT3 NUMERIC(38,0)
);