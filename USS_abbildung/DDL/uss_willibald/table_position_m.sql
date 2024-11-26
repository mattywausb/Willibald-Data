
-- DROP TABLE uss_willibald.position_m;

CREATE TABLE uss_willibald.position_m (
	md_inserted_at timestamp default current_timestamp,
	_key_position_m varchar(100) NOT NULL,
	menge numeric(10),
	preis numeric(10,2)
);