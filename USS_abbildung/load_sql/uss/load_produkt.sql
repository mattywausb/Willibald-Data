/* loads produkt daten into bridge and produkt table */


delete from uss_willibald._bridge_willibald 
where stage ='produkt';

insert into uss_willibald._bridge_willibald (stage,_key_produkt,_key_produkt_m) 
	select distinct 'produkt'
		,produktid
		,produktid
	from willibald_xt.produkt;

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
from  willibald_xt.produkt p
join willibald_xt.kategorie k1 on k1.katid =p.katid 
left join willibald_xt.kategorie k2 on k2.katid =k1.oberkatid 
left join willibald_xt.kategorie k3 on k3.katid =k2.oberkatid 
join willibald_xt.REF_PRODUKT_TYP pt on pt.typ =p.typ ;

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
werbebudget   -- just make up some Budget, depedning on KatID
from  willibald_xt.produkt p

/* 
 * select * from 	 uss_willibald.produkt_m
 */