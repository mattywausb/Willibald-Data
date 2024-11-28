/* loads kunde daten into bridge and kunde table */


delete from uss_willibald._bridge_willibald 
where stage ='kunde';

insert into uss_willibald._bridge_willibald (stage,_key_kunde,_key_vereinspartner) 
	select distinct 'kunde'
		, kundeid 
		,vereinspartnerid 
	from willibald_shop_p1.kunde;

/* 
 * select * from 	 uss_willibald._bridge_willibald
 */

truncate table uss_willibald.kunde;

INSERT INTO uss_willibald.kunde
(_key_kunde, kundeid, vorname, name, geschlecht, geburtsdatum)
select 
	kundeid ,
	kundeid ,
	vorname ,
	name ,
	geschlecht ,
	geburtsdatum 
from  willibald_shop_p1.kunde;

/* 
 * select * from 	 uss_willibald.kunde
 */