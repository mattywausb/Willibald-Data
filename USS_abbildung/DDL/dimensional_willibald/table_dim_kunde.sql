-- DROP TABLE DIMENSIONAL_WILLIBALD.dim_kunde;

CREATE TABLE DIMENSIONAL_WILLIBALD.dim_kunde (
	md_inserted_at timestamp default current_timestamp,
	_dk_kunde  varchar(13) NOT NULL,
	kundeid  varchar(13),
	vorname varchar(128),
	geschlecht  varchar(1),
	geburtsjahr number(4) ,
	kreditkartenfirma  varchar(128)
);