
-- DROP TABLE uss_willibald.job_instance_status

CREATE TABLE uss_willibald.bridge_willibald (
	md_inserted_at timestamp default current_timestamp
	,stage varchar(255) not null
	,_key_bestellung number(20)
	,_key_kunde varchar(13)
	,_key_lieferadresse number(10)
	,_key_lieferdienstid varchar(30)
	,_key_position number(20)
	,_key_produkt number(10)
	,_key_vereinspartner varchar(30)
);
