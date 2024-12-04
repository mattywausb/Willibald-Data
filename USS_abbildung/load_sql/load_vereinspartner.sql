/* loads kunde daten into bridge and kunde table */


delete from uss_willibald._bridge_willibald 
where stage ='vereinspartner';

insert into uss_willibald._bridge_willibald (stage,_key_vereinspartner,_key_kunde) 
	select distinct 'vereinspartner'
		,vereinspartnerid 
		, kundeidverein 
	from willibald_shop_p1.vereinspartner;

/* 
 * select * from 	 uss_willibald._bridge_willibald
 */

truncate table uss_willibald.vereinspartner;

INSERT INTO uss_willibald.vereinspartner 
( _KEY_VEREINSPARTNER, VEREINSPARTNERID, RABATT1, RABATT2, RABATT3)
select 
	vereinspartnerid ,
	vereinspartnerid ,
	rabatt1 ,
	rabatt2 ,
	rabatt3 
from  willibald_shop_p1.vereinspartner ;

/* 
 * select * from 	 uss_willibald.kunde
 */