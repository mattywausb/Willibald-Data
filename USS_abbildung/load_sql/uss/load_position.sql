/* loads position daten into bridge and position table */


delete from uss_willibald._bridge_willibald 
where stage ='position';

insert into uss_willibald._bridge_willibald (stage,_key_position,_key_position_m,_key_bestellung
											,_key_produkt ,_key_lieferadresse,_key_kunde,_key_vereinspartner) 
	select distinct 'position'
		, p.bestellungid||'-->'||posid 
		, p.bestellungid||'-->'||posid 
		, p.bestellungid 
		, p.produktid
		, allglieferadrid 
		, b.kundeid 
		, k.vereinspartnerid 
	from willibald_xt.position p 
	join willibald_xt.bestellung b on b.bestellungid =p.bestellungid
	left join willibald_xt.kunde k on k.kundeid = b.kundeid 
	left join willibald_xt.produkt pd on pd.produktid = p.produktid 
	where p.bestellungid in (Select bestellungid from willibald_xt.data_sample_bestellung);

/* 
 * select * from 	 uss_willibald._bridge_willibald where stage='position'
 */

truncate table uss_willibald.position;

INSERT INTO uss_willibald.position
( _key_position, posid, was_delivered,ad_landing)
select 
	 p.bestellungid||'-->'||p.posid 
	,p.posid
	,was_delivered
	,ad_landing
from  willibald_xt.position p
	where p.bestellungid in (Select bestellungid from willibald_xt.data_sample_bestellung);


/* 
 * select * from 	 uss_willibald.position
 */


truncate table uss_willibald.position_m;

INSERT INTO uss_willibald.position_m
( _key_position_m, menge, betrag_position)
select 
	bestellungid||'-->'||posid 
	,menge
	,preis 
from  willibald_xt.position p
	where p.bestellungid in (Select bestellungid from willibald_xt.data_sample_bestellung);


/* 
 * select * from 	 uss_willibald.position_m
 */