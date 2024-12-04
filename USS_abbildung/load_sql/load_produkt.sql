/* loads produkt daten into bridge and produkt table */


delete from uss_willibald._bridge_willibald 
where stage ='produkt';

insert into uss_willibald._bridge_willibald (stage,_key_produkt,_key_produkt_m) 
	select distinct 'produkt'
		,produktid
		,produktid
	from willibald_shop_p1.produkt;

/* 
 * select * from 	 uss_willibald._bridge_willibald where stage='bestellung'
 */

truncate table uss_willibald.produkt;

INSERT INTO uss_willibald.produkt
(_key_produkt, produktid, bezeichnung, umfang, preis, pflanzort, pflanzabstand, pflanztyp,kategorie, zehrgruppe, oberkategorie)
select 
produktid,
produktid, 
p.bezeichnung,
umfang,
preis,
pflanzort,
pflanzabstand,
pt.bezeichnung as pflanztyp, 
k1.name ,
k2.name, 
k3.name 
from  willibald_shop_p1.produkt p
join willibald_shop_p1.kategorie k1 on k1.katid =p.katid 
left join willibald_shop_p1.kategorie k2 on k2.katid =k1.oberkatid 
left join willibald_shop_p1.kategorie k3 on k3.katid =k2.oberkatid 
join WILLIBALD_SHOP_P1.REF_PRODUKT_TYP pt on pt.typ =p.typ ;

/* 
 * select * from 	 uss_willibald.produkt
 */


/* 
 * select * from 	 uss_willibald._bridge_willibald where stage='bestellung'
 */

truncate table uss_willibald.produkt_m;

INSERT INTO uss_willibald.produkt_m
(_key_produkt_m, werbebudget)
select 
produktid,
case when left(katid,3)='GSt' then 15000
	when left(katid,3)='GSc' then 10800
	when left(katid,2)='GM' then 22000
	ELSE 5000 end werbebudget   -- just make up some Budget, depedning on KatID
from  willibald_shop_p1.produkt p

/* 
 * select * from 	 uss_willibald.produkt_m
 */