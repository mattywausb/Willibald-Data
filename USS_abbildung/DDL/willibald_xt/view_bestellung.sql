-- DROP view willibald_xt.bestellung ;

CREATE or replace view willibald_xt.bestellung as

with positionssumme as (
	select p.bestellungid , sum(p.preis ) summe_positionen
	from willibald_shop_p1.POSITION p
	group by 1
)
, rabatt_und_bonus as (
select 
	b.bestellungid ,
	summe_positionen,
	ps.summe_positionen*rabatt/100 as  RABATTBETRAG,
	case when v.rabatt1 is not null 
		then v.rabatt1 /2.0 
		else 0 end 			  as MITGLIEDSBONUS  -- artifical generation of "noise"
from  willibald_shop_p1.bestellung b
join positionssumme ps on ps.bestellungid = b.bestellungid 
left join willibald_shop_p1.vereinspartner v on v.kundeidverein =b.kundeid 
)
select 
	b.*
	,mitgliedsbonus
	,round(greatest(summe_positionen-rabattbetrag-mitgliedsbonus,0)*1.19,2) as GESAMTBETRAG
	,round(greatest(summe_positionen-rabattbetrag-mitgliedsbonus,0)*0.19,2) as UMSATZSTEUER
from willibald_shop_p1.bestellung b
join rabatt_und_bonus rb on rb.bestellungid= b.bestellungid 
;


