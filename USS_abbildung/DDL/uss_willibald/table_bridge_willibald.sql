
-- DROP TABLE uss_willibald.job_instance_status

CREATE TABLE uss_willibald.bridge_willibald (
	md_inserted_at timestamp default current_timestamp
	,stage varchar(255) not null
	,_key_bestellung int8
	,_key_kunde bpchar(13)
	,_key_lieferadresse int4
	,_key_lieferdienstid varchar(30)
	,_key_position int8
	,_key_produkt int4
	,_key_vereinspartner varchar(30)
);
