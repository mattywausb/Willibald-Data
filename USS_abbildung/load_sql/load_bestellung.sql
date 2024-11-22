/* loads bestellung daten into bridge and bestellung table */


delete from uss_willibald.bridge_willibald 
where stage ='bestellung';

insert into uss_willibald.bridge_willibald (stage,"_key_bestellung","_key_kunde","_key_lieferadresse") 
	select distinct 'bestellung'
		, bestellungid 
		, kundeid
		, allglieferadrid
	from willibald_shop_p1.bestellung;

/* 
 * select * from 	 uss_willibald.bridge_willibald where stage='bestellung'
 */

truncate table uss_willibald.bestellung

INSERT INTO uss_willibald.bestellung
("_key_bestellung", bestellungid, bestelldatum, wunschdatum, rabatt)
select 
	bestellungid ,
	bestellungid ,
	bestelldatum ,
	wunschdatum ,
	rabatt 
from  willibald_shop_p1.bestellung;

/* 
 * select * from 	 uss_willibald.bestellung
 */