-- DROP TABLE DIMENSIONAL_WILLIBALD.dim_vereinspartner;

CREATE TABLE DIMENSIONAL_WILLIBALD.dim_vereinspartner (
	md_inserted_at timestamp default current_timestamp,
	_dk_vereinspartner  varchar(30) NOT NULL,
	VEREINSPARTNERID VARCHAR(30) NOT NULL,
	RABATT1 NUMERIC(38,0),
	RABATT2 NUMERIC(38,0),
	RABATT3 NUMERIC(38,0)
);