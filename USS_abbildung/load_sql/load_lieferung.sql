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
	from willibald_shop_p1.lieferung l
	left join willibald_shop_p1.bestellung b on b.bestellungid =l.bestellungid
	left join willibald_shop_p1.position p on p.bestellungid =l.bestellungid and p.posid=l.posid
	left join willibald_shop_p1.kunde k on k.kundeid = b.kundeid 
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
	from willibald_shop_p1.lieferung l
;

/* 
 * select * from uss_willibald.lieferung
 */

truncate table uss_willibald.lieferung_m ;

INSERT INTO uss_willibald.lieferung_m 
(_key_lieferung_m,lieferkosten)
	select 
	l.bestellungid||'-->'||l.posid||'-->'||l.lieferadrid ||'-->'||l.lieferdienstid 
	,mod (coalesce(la.plz,0),7)*0.80+2 lieferkosten -- Mocking some costs with no real context
	from willibald_shop_p1.lieferung l
	left join willibald_shop_p1.lieferadresse la on la.lieferadrid =l.lieferadrid 
;

/* 
 * select * from uss_willibald.lieferung_m
 */

