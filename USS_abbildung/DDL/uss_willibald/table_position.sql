
-- DROP TABLE uss_willibald.position;

CREATE TABLE uss_willibald.position (
	md_inserted_at timestamp default current_timestamp,
	_key_position varchar(100) NOT NULL,
	posid numeric(20)
	,was_delivered boolean
	,ad_landing boolean
);

alter table uss_willibald.position add constraint PK_position PRIMARY KEY(_key_position);