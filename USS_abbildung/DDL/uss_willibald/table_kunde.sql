-- DROP TABLE uss_willibald.kunde;

CREATE TABLE uss_willibald.kunde (
	md_inserted_at timestamp default current_timestamp,
	_key_kunde bpchar(13) NOT NULL,
	kundeid bpchar(13),
	vorname varchar(128) NOT NULL,
	"name" varchar(128) NOT NULL,
	geschlecht bpchar(1) NULL,
	geburtsdatum date NOT NULL
);