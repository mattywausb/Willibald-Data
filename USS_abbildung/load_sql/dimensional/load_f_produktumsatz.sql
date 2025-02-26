/* loads position daten into bridge and position table */


truncate table dvf_uss_demo.dimensional_willibald.f_produktumsatz;

insert into dvf_uss_demo.dimensional_willibald.f_produktumsatz
(_dk_bestellung
, _dk_kunde
, _dk_lieferdienst
, _dk_produkt
, _dk_vereinspartner
, ad_landing
, posid
, betrag_position
, betrag_position_verrechnet
, menge
, verkaufstag
, was_delivered)

with liefer_ranking as (
	Select bestellungid ,posid ,lieferdienstid 
	,rank() over (partition by bestellungid,posid order by lieferdatum desc,lieferdienstid desc) lieferung_rank
	from willibald_xt.lieferung 
)
select distinct 
		 b.bestellungid 
		, b.kundeid 
		,lr.lieferdienstid
		, p.produktid
		, k.vereinspartnerid 
		, p.ad_landing 
		, p.posid
		, p.preis betrag_position
		,p.preis-round((b.rabattbetrag+b.mitgliedsbonus)*p.preis/b.summe_positionen_netto,2)
						as betrag_position_verrechnet
		, menge
		, b.bestelldatum verkaufstag
		, was_delivered		
	from willibald_xt.bestellung b  
	left join willibald_xt."POSITION" p on p.bestellungid =b.bestellungid
	left join liefer_ranking lr on lr.bestellungid = p.bestellungid
								and lr.posid= p.posid
								and lieferung_rank=1
	left join willibald_xt.kunde k on k.kundeid = b.kundeid 
	left join willibald_xt.produkt pd on pd.produktid = p.produktid 
	where b.bestellungid in (Select bestellungid from willibald_xt.data_sample_bestellung);

/*
  select * from dvf_uss_demo.dimensional_willibald.f_produktumsatz;
  */
