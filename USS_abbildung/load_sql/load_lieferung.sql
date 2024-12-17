/* loads lieferung daten into bridge and produkt table */

delete from uss_willibald._bridge_willibald 
where stage ='lieferung';

insert into uss_willibald._bridge_willibald (stage,_key_lieferung,_key_lieferung_m,_key_position,_key_bestellung,
											_key_lieferdienstid,_key_lieferadresse,_key_produkt,
											_key_kunde,_key_vereinspartner) 
	select distinct 'lieferung'
		,l.bestellungid||'-->'||l.posid||'-->'||l.lieferadrid ||'-->'||l.lieferdienstid 
		,l.bestellungid||'-->'||l.posid||'-->'||l.lieferadrid ||'-->'||l.lieferdienstid 
		,l.bestellungid||'-->'||l.posid 
		,b.bestellungid
		,l.lieferdienstid 
		,l.lieferadrid 
		,p.produktid
		,k.kundeid 
		,k.vereinspartnerid 
	from willibald_xt.lieferung l
	left join willibald_xt.bestellung b on b.bestellungid =l.bestellungid
	left join willibald_xt.position p on p.bestellungid =l.bestellungid and p.posid=l.posid
	left join willibald_xt.kunde k on k.kundeid = b.kundeid 
;

/* 
 * select * from 	 uss_willibald._bridge_willibald where stage='lieferung'
 */

truncate table uss_willibald.lieferung ;

INSERT INTO uss_willibald.lieferung 
(_key_lieferung,lieferdatum)
	select 
	l.bestellungid||'-->'||l.posid||'-->'||l.lieferadrid ||'-->'||l.lieferdienstid 
	,l.lieferdatum 
	from willibald_xt.lieferung l
;

/* 
 * select * from uss_willibald.lieferung
 */

truncate table uss_willibald.lieferung_m ;

INSERT INTO uss_willibald.lieferung_m 
(_key_lieferung_m,lieferkosten)
	select 
	l.bestellungid||'-->'||l.posid||'-->'||l.lieferadrid ||'-->'||l.lieferdienstid 
	, lieferkosten -- Mocking some costs with no real context
	from willibald_xt.lieferung l
;

/* 
 * select * from uss_willibald.lieferung_m
 */

