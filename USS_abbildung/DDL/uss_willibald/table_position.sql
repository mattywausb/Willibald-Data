
-- DROP TABLE uss_willibald."position";

CREATE TABLE uss_willibald."position" (
	md_inserted_at timestamp default current_timestamp,
	_key_position int8 NOT NULL,
	posid int8 NOT NULL,
	menge int4 NOT NULL,
	preis numeric(10, 2) NOT NULL
);