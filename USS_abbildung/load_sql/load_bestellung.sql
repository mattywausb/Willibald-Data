/* loads bestellung daten into bridge and bestellung table */


delete from uss_willibald._bridge_willibald 
where stage ='bestellung';

insert into uss_willibald._bridge_willibald (stage,_key_bestellung,_key_bestellung_m,_key_kunde,_key_lieferadresse) 
	select distinct 'bestellung'
		, bestellungid 
		, bestellungid 
		, kundeid
		, allglieferadrid
	from willibald_shop_p1.bestellung;

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
from  willibald_shop_p1.bestellung;

/* 
 * select * from 	 uss_willibald.bestellung
 */

truncate table uss_willibald.bestellung_m;

INSERT INTO uss_willibald.bestellung_m
(_KEY_BESTELLUNG_M, RABATTBETRAG, MITGLIEDSBONUS, GESAMTBETRAG, UMSATZSTEUERNUMBER)
with positionssumme as (
select p.bestellungid , sum(p.preis ) summe_positionen
from willibald_shop_p1.POSITION p
group by 1
)
, rabatt_und_bonus as (
select 
	b.bestellungid ,
	RABATT,
	summe_positionen,
	ps.summe_positionen*rabatt/100 as  RABATTBETRAG,
	case when v.rabatt1 is not null 
		then v.rabatt1 /2.0 
		else 0 end 			  as MITGLIEDSBONUS
from  willibald_shop_p1.bestellung b
join positionssumme ps on ps.bestellungid = b.bestellungid 
left join willibald_shop_p1.vereinspartner v on v.kundeidverein =b.kundeid 
)
select 
	bestellungid
	,rabatt
	,mitgliedsbonus
	,round(greatest(summe_positionen-rabattbetrag-mitgliedsbonus,0)*1.19,2) as GESAMTBETRAG
	,round(greatest(summe_positionen-rabattbetrag-mitgliedsbonus,0)*0.19,2) as UMSATZSTEUER
from rabatt_und_bonus
;
