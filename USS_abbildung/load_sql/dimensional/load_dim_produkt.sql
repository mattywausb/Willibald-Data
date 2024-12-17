
truncate table DIMENSIONAL_WILLIBALD.DIM_PRODUKT;

INSERT INTO DIMENSIONAL_WILLIBALD.DIM_PRODUKT
(_DK_PRODUKT
, PRODUKTID
, BEZEICHNUNG
, UMFANG
, PFLANZTYP
, PREIS
, PFLANZORT
, PFLANZABSTAND
, KATEGORIE
, ZEHRGRUPPE
, OBERKATEGORIE
, WERBEBUDGET)
select 
produktid,
produktid, 
p.bezeichnung,
umfang,
pt.bezeichnung as pflanztyp, 
preis,
pflanzort,
pflanzabstand,
k1.name ,
k2.name, 
k3.name,
p.werbebudget 
from  willibald_xt.produkt p
join willibald_xt.kategorie k1 on k1.katid =p.katid 
left join willibald_xt.kategorie k2 on k2.katid =k1.oberkatid 
left join willibald_xt.kategorie k3 on k3.katid =k2.oberkatid 
join willibald_xt.REF_PRODUKT_TYP pt on pt.typ =p.typ ;

