
-- DROP TABLE uss_willibald._bridge_willibald

CREATE TABLE uss_willibald._bridge_willibald (
	md_inserted_at timestamp default current_timestamp
	,stage varchar(255) not null
	,_key_bestellung numeric(20)
	,_key_bestellung_m numeric(20)
	,_key_kunde varchar(13)
	,_key_lieferadresse numeric(10)
	,_key_lieferdienstid varchar(30)
	,_key_lieferung varchar(100)
	,_key_lieferung_m varchar(100)
	,_key_position varchar(100)
	,_key_position_m varchar(100)
	,_key_produkt numeric(10)
	,_key_produkt_m numeric(10)
	,_key_vereinspartner varchar(30)
	,_key_umsatzplan_prod varchar(128)
	,_key_umsatzplan_prodkat varchar(128)
);

-- alter table uss_willibald._bridge_willibald add column 	_key_umsatzplan_prod varchar(128);
-- alter table uss_willibald._bridge_willibald add column 	_key_umsatzplan_prodkat varchar(128);
-- alter table uss_willibald._bridge_willibald drop column 	oberkategorie ;

alter table uss_willibald.bestellung add constraint FK_bestellung FOREIGN KEY(_key_bestellung) references uss_willibald.bestellung(_key_bestellung);
alter table uss_willibald.bestellung_m add constraint FK_bestellung_m FOREIGN KEY(_key_bestellung_m) references uss_willibald.bestellung_m(_key_bestellung_m);
alter table uss_willibald.kunde add constraint FK_kunde FOREIGN KEY(_key_kunde) references uss_willibald.kunde(_key_kunde);
alter table uss_willibald.lieferung add constraint FK_lieferung FOREIGN KEY(_key_lieferung) references uss_willibald.lieferung(_key_lieferung);
alter table uss_willibald.lieferung_m add constraint FK_lieferung_m FOREIGN KEY(_key_lieferung_m) references uss_willibald.lieferung_m(_key_lieferung_m);
alter table uss_willibald.position add constraint FK_position FOREIGN KEY(_key_position) references uss_willibald.position(_key_position);
alter table uss_willibald.position_m add constraint FK_position_m FOREIGN KEY(_key_position_m) references uss_willibald.position_m(_key_position_m);
alter table uss_willibald.produkt add constraint FK_produkt FOREIGN KEY(_key_produkt) references uss_willibald.produkt(_key_produkt);
alter table uss_willibald.produkt_m add constraint FK_produkt_m FOREIGN KEY(_key_produkt_m) references uss_willibald.produkt_m(_key_produkt_m);
alter table uss_willibald.vereinspartner add constraint FK_vereinspartner FOREIGN KEY(_key_vereinspartner) references uss_willibald.vereinspartner(_key_vereinspartner);
alter table uss_willibald.umsatzplan_prod add constraint FK_umsatzplan_prod FOREIGN KEY(_key_umsatzplan_prod) references uss_willibald.umsatzplan_prod(_key_umsatzplan_prod);
alter table uss_willibald.umsatzplan_prodkat add constraint FK_umsatzplan_prodkat FOREIGN KEY(_key_umsatzplan_prodkat) references uss_willibald.umsatzplan_prodkat(_key_umsatzplan_prodkat);
