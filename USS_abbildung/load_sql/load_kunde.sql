/* loads kunde daten into bridge and kunde table */


delete from uss_willibald._bridge_willibald 
where stage ='kunde';

insert into uss_willibald._bridge_willibald (stage,_key_kunde,_key_vereinspartner) 
	select distinct 'kunde'
		, kundeid 
		,vereinspartnerid 
	from willibald_xt.kunde;

/* 
 * select * from 	 uss_willibald._bridge_willibald
 */

truncate table uss_willibald.kunde;

INSERT INTO uss_willibald.kunde
(_key_kunde, kundeid, vorname, geschlecht, geburtsjahr,kreditkartenfirma)
select 
	kundeid ,
	kundeid ,
	vorname ,
	geschlecht ,
	year(geburtsdatum )geburtsjahr ,
	kkfirma
from  willibald_xt.kunde;

/* 
 * select * from 	 uss_willibald.kunde
 */