/* loads produkt daten into bridge and produkt table */


delete from uss_willibald._bridge_willibald 
where stage ='umsatzplan_prod';

insert into uss_willibald._bridge_willibald (stage,_key_umsatzplan_prod,_key_produkt) 
	select distinct 'umsatzplan_prod'
		,produktid||'-->'||jahr ||'-->'||quartal 
		,produktid
	from jahresplanung.umsatzplan_prod ;

/* 
 * select * from 	 uss_willibald._bridge_willibald where stage='umsatzplan_prod'
 */

truncate table uss_willibald.umsatzplan_prod ;

INSERT INTO uss_willibald.umsatzplan_prod
(_key_umsatzplan_prod, jahr, quartal, geplanter_produkt_umsatz)
select 
produktid||'-->'||jahr ||'-->'||quartal 
,jahr
,quartal
,geplanter_produkt_umsatz
from jahresplanung.umsatzplan_prod ;

/* 
 * select * from 	 uss_willibald.umsatzplan_prod
 */
