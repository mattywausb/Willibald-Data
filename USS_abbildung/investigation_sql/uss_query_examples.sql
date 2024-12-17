

/* simples Beispiel */
use schema uss_willibald;
select BEZEICHNUNG , sum(BETRAG_POSITION) umsatz, sum(MENGE) anzahl
	 from _BRIDGE_WILLIBALD 
	 join PRODUKT   		using (_key_produkt)
--left join BESTELLUNG  		using (_key_bestellung)
left join POSITION  		using (_key_position)
group by 1
order by 1;

/* Werte aus Position und  Bestellung */
use schema uss_willibald;
select bestellung.	BESTELLDATUM
	  ,position.	BETRAG_POSITION 	
	  ,bestellung_m.MITGLIEDSBONUS 	
	  ,bestellung_m.RABATTBETRAG 	
	 from _BRIDGE_WILLIBALD 
	 join BESTELLUNG  		using (_key_bestellung)
left join BESTELLUNG_M 		using (_key_bestellung_m)
left join POSITION  		using (_key_position)
order by _key_bestellung,_key_position

/* + Werte aus der Bestellung */
use schema uss_willibald;
select bestellung.bestelldatum
	  ,sum(BETRAG_POSITION) betrag_position_sum
	  ,sum(MITGLIEDSBONUS) mitgliedsbonus_sum
      ,sum(RABATTBETRAG) rabattbetrag_sum
	 from _BRIDGE_WILLIBALD 
     join BESTELLUNG  		using (_key_bestellung)
left join BESTELLUNG_M 		using (_key_bestellung_m)
left join POSITION  		using (_key_position)
group by 1 order by 1;

/* Experimentierfeld 1 */
select stage,b.bestelldatum ,v.vereinspartnerid ,pd.pflanztyp,
	count(distinct _key_kunde) anzahl_kunden,
	sum(p_m.menge) menge, sum(p_m.preis) preis, sum(b_m.gesamtbetrag) rechnungsbetrag
from uss_willibald._bridge_willibald 
left join uss_willibald.vereinspartner v using (_key_vereinspartner)
left join uss_willibald.bestellung b using (_key_bestellung)
left join uss_willibald.bestellung_m b_m using (_key_bestellung_m)
left join uss_willibald.position_m p_m using (_key_position_m)
left join uss_willibald.produkt pd using (_key_produkt)
--where stage='bestellung'
where stage<>'lieferung'
group by 1,2,3,4
order by 2,3,4,1;

/* Sum positionen und gesamtbetrag eines Kunden*/
select br._key_kunde,
from uss_willibald._bridge_willibald br
left join uss_willibald.bestellung b_m using (_key_bestellung_m)
left join uss_willibald.bestellung b_m using (_key_bestellung_m)
where stage='bestellung'
group by 1,2
order by 1,2



/* summe umsatz, oberkategorie */
select b.bestelldatum ,pd.oberkategorie ,ad_landing, sum(ps.preis)
from uss_willibald._bridge_willibald 
join uss_willibald.bestellung b using (_key_bestellung)
join uss_willibald.produkt pd  using (_key_produkt)
join uss_willibald.POSITION_m ps using (_key_position_m)
group by 1,2,3
order by 1,2,3

/* Planzahlen */
select coalesce (upk.oberkategorie,p.oberkategorie) oberkategorie ,
		bezeichnung,
		coalesce (up.jahr,upk.jahr ) jahr,
		quartal,
		monat,
		up.geplanter_produkt_umsatz ,
		upk.geplanter_kategorie_umsatz 
from uss_willibald._bridge_willibald 
left join uss_willibald.produkt p using (_key_produkt)
left join uss_willibald.umsatzplan_prod up using (_key_umsatzplan_prod)
left join uss_willibald.umsatzplan_prodkat upk using (_key_umsatzplan_prodkat)
where _key_umsatzplan_prod is not null or _key_umsatzplan_prodkat is not null


/* Monats Planzahlen + Umsatzzahlen */
select 
	coalesce(upk.oberkategorie,pd.oberkategorie) oberkategorie
	,coalesce(upk.jahr,year(b.bestelldatum)) jahr
	,coalesce(upk.monat ,month(b.bestelldatum)) monat
	,sum(upk.geplanter_kategorie_umsatz) geplanter_kategorie_umsatz
	,sum(ps_m.preis) umsatz
 from uss_willibald._bridge_willibald 
left join uss_willibald.bestellung b using (_key_bestellung)
left join uss_willibald.position_m ps_m using (_key_position_m)
left join uss_willibald.produkt pd using (_key_produkt)
left join uss_willibald.umsatzplan_prodkat upk using (_key_umsatzplan_prodkat)
where _key_umsatzplan_prodkat is not null or _key_position is not null
group by 1,2,3
order by 1,2,3