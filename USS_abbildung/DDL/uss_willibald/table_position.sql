
-- DROP TABLE uss_willibald."position";

CREATE TABLE uss_willibald.position (
	md_inserted_at timestamp default current_timestamp,
	_key_position numeric(20) NOT NULL,
	posid numeric(20) NOT NULL,
	menge numeric(10) NOT NULL,
	preis numeric(10, 2) NOT NULL
);