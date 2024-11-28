
-- DROP TABLE uss_willibald.Lieferung;

CREATE TABLE uss_willibald.Lieferung (
	md_inserted_at timestamp default current_timestamp,
	_key_lieferung varchar(100) NOT NULL,
    LieferDatum date  NOT NULL
);


