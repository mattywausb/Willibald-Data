/* loads position daten into bridge and position table */


delete from uss_willibald.bridge_willibald 
where stage ='position';

insert into uss_willibald.bridge_willibald (stage,"_key_position","_key_bestellung","_key_produkt" ,"_key_lieferadresse") 
	select distinct 'position'
		, posid 
		, bestellungid 
		, produktid
		, produktid
	from willibald_shop_p1.position;

/* 
 * select * from 	 uss_willibald.bridge_willibald where stage='position'
 */

truncate table uss_willibald.position;

INSERT INTO uss_willibald.position
( "_key_position", posid, menge, preis)
select 
	posid,
	posid,
	menge,
	preis 
from  willibald_shop_p1.position;

/* 
 * select * from 	 uss_willibald.position
 */