

/* Key count per stage in der bridge  */

select stage,count(1)
--,count(_key_bestellung) bestellung,count(distinct _key_bestellung) bestellung_dist
--,count(_key_bestellung_m) bestellung_m,count(distinct _key_bestellung_m) bestellung_m_dist
--,count(_key_kunde) kunde,count(distinct _key_kunde) kunde_dist
,count(_key_lieferung) lieferung,count(distinct _key_lieferung) lieferung_dist
,count(_key_lieferung_m) lieferung_m,count(distinct _key_lieferung_m) lieferung_m_dist
,count(_key_position) position,count(distinct _key_position) position_dist
,count(_key_position_m) position_m,count(distinct _key_position_m) position_m_dist
--,count(_key_produkt) produkt,count(distinct _key_produkt) produkt_dist
--,count(_key_produkt_m) produkt_m,count(distinct _key_produkt_m) produkt_m_dist
--,count(_key_umsatzplan_prod) umsatzplan_prod,count(distinct _key_umsatzplan_prod) umsatzplan_prod_dist
--,count(_key_umsatzplan_prodkat) umsatzplan_prodkat,count(distinct _key_umsatzplan_prodkat) umsatzplan_prodkat_dist
--,count(_key_vereinspartner) vereinspartner,count(distinct _key_vereinspartner) vereinspartner_dist
from uss_willibald._bridge_willibald 
group by 1
order by 1;

/* key count in tables */

select 'bestellung' table_name, count(1) row_count,count(distinct _key_bestellung) key_count
from uss_willibald.bestellung
group by 1
union
select 'bestellung_m' table_name, count(1),count(distinct _key_bestellung_m)
from uss_willibald.bestellung_m
group by 1
union
select 'kunde',count(1),count(distinct _key_kunde)
from uss_willibald.kunde
group by 1
union
select 'lieferung',count(1),count(distinct _key_lieferung)
from uss_willibald.lieferung
group by 1
union
select 'lieferung_m',count(1),count(distinct _key_lieferung_m)
from uss_willibald.lieferung_m
group by 1
union
select 'produkt',count(1),count(distinct _key_produkt)
from uss_willibald.produkt
group by 1
union
select 'produkt_m',count(1),count(distinct _key_produkt_m)
from uss_willibald.produkt_m
group by 1
union
select 'position',count(1),count(distinct _key_position)
from uss_willibald.position
group by 1
union
select 'position_m',count(1),count(distinct _key_position_m)
from uss_willibald.position_m
group by 1
union
select 'umsatzplan_prod',count(1),count(distinct _key_umsatzplan_prod)
from uss_willibald.umsatzplan_prod
group by 1
union
select 'umsatzplan_prodkat',count(1),count(distinct _key_umsatzplan_prodkat)
from uss_willibald.umsatzplan_prodkat
group by 1
union
select 'vereinspartner',count(1),count(distinct _key_vereinspartner)
from uss_willibald.vereinspartner
order by 1;

