/* Scripts that remove some data and produce inconsistencys in bestellung and product */


delete from willibald_shop_p1."POSITION" where bestellungid in(5,300);
delete from willibald_shop_p1.produkt where produktid in(40,93);

select distinct _key_bestellung ,_key_produkt 
from uss_willibald._bridge_willibald 
where _key_bestellung is not null and _key_produkt is not null;




select *
from willibald_shop_p1."POSITION" 
where produktid not in (select produktid from willibald_shop_p1.produkt )








