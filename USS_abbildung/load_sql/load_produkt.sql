/* loads produkt daten into bridge and produkt table */


delete from uss_willibald.bridge_willibald 
where stage ='produkt';

insert into uss_willibald.bridge_willibald (stage,"_key_produkt") 
	select distinct 'produkt'
		,produktid
	from willibald_shop_p1.produkt;

/* 
 * select * from 	 uss_willibald.bridge_willibald where stage='bestellung'
 */

truncate table uss_willibald.produkt

INSERT INTO uss_willibald.produkt
("_key_produkt", produktid, bezeichnung, umfang, typ, preis, pflanzort, pflanzabstand, kategorie, oberkategorie)
select 
produktid,
produktid, 
bezeichnung,
umfang,
typ,
preis,
pflanzort,
pflanzabstand,
k1."name" ,
k2."name" 
from  willibald_shop_p1.produkt p
join willibald_shop_p1.kategorie k1 on k1.katid =p.katid 
join willibald_shop_p1.kategorie k2 on k2.katid =k1.oberkatid ;

/* 
 * select * from 	 uss_willibald.produkt
 */