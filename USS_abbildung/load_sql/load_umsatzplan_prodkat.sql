/* loads produkt daten into bridge and produkt table */


delete from uss_willibald._bridge_willibald 
where stage ='umsatzplan_prodkat';

insert into uss_willibald._bridge_willibald (stage,_key_umsatzplan_prodkat) 
	select distinct 'umsatzplan_prodkat'
		,oberkategorie||'-->'|| jahr ||'-->'||monat 
	from jahresplanung.umsatzplan_prodkat ;

/* 
 * select * from 	 uss_willibald._bridge_willibald where stage='umsatzplan_prodkat' order by _key_umsatzplan_prodkat
 */

truncate table uss_willibald.umsatzplan_prodkat ;

INSERT INTO uss_willibald.umsatzplan_prodkat
(_key_umsatzplan_prodkat,oberkategorie, jahr, monat, geplanter_kategorie_umsatz)
select 
oberkategorie||'-->'|| jahr ||'-->'||monat 
,oberkategorie
,jahr
,monat
,geplanter_kategorie_umsatz 
from jahresplanung.umsatzplan_prodkat ;

/* 
 * select * from 	 uss_willibald.umsatzplan_prodkat
 */
