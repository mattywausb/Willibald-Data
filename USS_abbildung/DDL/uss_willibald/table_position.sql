
-- DROP TABLE uss_willibald.position;

CREATE TABLE uss_willibald.position (
	md_inserted_at timestamp default current_timestamp,
	_key_position varchar(100) NOT NULL,
	posid numeric(20)
	,	menge numeric(10)
	,betrag_position numeric(10,2)
	,was_delivered boolean
	,ad_landing boolean
);