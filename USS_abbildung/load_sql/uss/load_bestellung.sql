/* loads bestellung daten into bridge and bestellung table */


delete from uss_willibald._bridge_willibald 
where stage ='bestellung';

insert into uss_willibald._bridge_willibald (stage,_key_bestellung,_key_bestellung_m,_key_kunde,_key_lieferadresse,_key_vereinspartner) 
	select distinct 'bestellung'
		, bestellungid 
		, bestellungid 
		, k.kundeid
		, b.allglieferadrid
		, k.vereinspartnerid 
	from willibald_xt.bestellung b
	left join willibald_xt.kunde k on k.kundeid = b.kundeid ;

/* 
 * select * from 	 uss_willibald._bridge_willibald where stage='bestellung'
 */

truncate table uss_willibald.bestellung;

INSERT INTO uss_willibald.bestellung
(_key_bestellung, bestellungid, bestelldatum, wunschdatum)
select 
	bestellungid ,
	bestellungid ,
	bestelldatum ,
	wunschdatum ,
from  willibald_xt.bestellung;

/* 
 * select * from 	 uss_willibald.bestellung
 */

truncate table uss_willibald.bestellung_m;

INSERT INTO uss_willibald.bestellung_m
(_KEY_BESTELLUNG_M, RABATTBETRAG, MITGLIEDSBONUS, GESAMTBETRAG, UMSATZSTEUER)
select 
	bestellungid
	,rabattbetrag
	,mitgliedsbonus
	,GESAMTBETRAG
	, UMSATZSTEUER
from willibald_xt.bestellung
;
