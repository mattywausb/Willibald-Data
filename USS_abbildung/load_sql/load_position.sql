/* loads position daten into bridge and position table */


delete from uss_willibald._bridge_willibald 
where stage ='position';

insert into uss_willibald._bridge_willibald (stage,_key_position,_key_position_m,_key_bestellung,_key_produkt ,_key_lieferadresse,_key_kunde) 
	select distinct 'position'
		, p.bestellungid||'-->'||posid 
		, p.bestellungid||'-->'||posid 
		, p.bestellungid 
		, produktid
		, allglieferadrid 
		, b.kundeid 
	from willibald_shop_p1.position p 
	join willibald_shop_p1.bestellung b on b.bestellungid =p.bestellungid;

/* 
 * select * from 	 uss_willibald._bridge_willibald where stage='position'
 */

truncate table uss_willibald.position;

INSERT INTO uss_willibald.position
( _key_position, posid, was_delivered)
select 
	 p.bestellungid||'-->'||p.posid 
	,p.posid
	,(l.posid is not null) as was_delivered
from  willibald_shop_p1.position p
left join WILLIBALD_SHOP_P1.LIEFERUNG l on l.bestellungid =p.bestellungid and l.posid =p.posid;

/* 
 * select * from 	 uss_willibald.position
 */


truncate table uss_willibald.position_m;

INSERT INTO uss_willibald.position_m
( _key_position_m, menge, preis)
select 
	bestellungid||'-->'||posid 
	,menge
	,preis 
from  willibald_shop_p1.position;

/* 
 * select * from 	 uss_willibald.position_m
 */