use schema dimensional_willibald;
--- !!! ^^^^^ do this first in the session ^^^^^!!!


/* simples Beispiel */
use schema dimensional_willibald;
select BEZEICHNUNG , sum(MENGE) anzahl,sum(BETRAG_POSITION) umsatz
from f_produktumsatz 
	 join dim_PRODUKT   		using (_dk_produkt)
group by 1
order by 1;

/* Werte aus Position und  Bestellung */
use schema dimensional_willibald;
select f.verkaufstag 
	  ,f.BETRAG_POSITION 	
	  ,d_b.MITGLIEDSBONUS 	
	  ,d_b.RABATTBETRAG 	
	  ,d_b.gesamtbetrag 
from f_produktumsatz f
	 join dim_BESTELLUNG d_b  		using (_dk_bestellung)
order by _dk_bestellung,posid

/* Werte auf Bestelltag summiert */
use schema dimensional_willibald;
select d_b.bestelldatum
	  ,sum(f.BETRAG_POSITION) betrag_position_sum
	  ,sum(d_b.MITGLIEDSBONUS) mitgliedsbonus_sum
      ,sum(d_b.RABATTBETRAG) rabattbetrag_sum
      ,sum(d_b.GESAMTBETRAG) gesamtbetrag_sum
	 from f_produktumsatz f
     join dim_BESTELLUNG d_b  		using (_dk_bestellung)
group by 1 order by 1;

/* Werte auf Bestelltag mit korrigierten positionen summiert */
use schema dimensional_willibald;
select d_b.bestelldatum
	  ,sum(f.BETRAG_POSITION) betrag_position_sum
	  ,sum(f.BETRAG_POSITION_VERRECHNET) betrag_position_verrechnet_sum
	  ,sum(round(f.BETRAG_POSITION_VERRECHNET*1.19,2)) betrag_position_verrechnet_sum_brutto
	 from f_produktumsatz f
     join dim_BESTELLUNG d_b  		using (_dk_bestellung)
group by 1 order by 1;

/* Werte auf Bestelltag mit voraggregat summiert */
use schema dimensional_willibald;
with bestellaggregat as (
	select _dk_bestellung 
		,sum(f.betrag_position) betrag_position_sum
	from f_produktumsatz f
	group by 1
)
select  d_b.bestelldatum
	  ,sum(a.betrag_position_sum) betrag_position_sum
	  ,sum(d_b.MITGLIEDSBONUS) mitgliedsbonus_sum
      ,sum(d_b.RABATTBETRAG) rabattbetrag_sum
      ,sum(d_b.GESAMTBETRAG) gesamtbetrag_sum from bestellaggregat a
     join dim_BESTELLUNG d_b  		using (_dk_bestellung)
group by 1 order by 1;

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