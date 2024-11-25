
/* Count kunde geschlecht über bestelldatum */
select b.bestelldatum ,k.geschlecht ,count(1)
from uss_willibald.bridge_willibald 
left join uss_willibald.kunde k using (_key_kunde)
left join uss_willibald.bestellung b using (_key_bestellung)
where stage='bestellung'
group by 1,2
order by 1,2


/* Count oberkategorie  über bestelldatum */
select b.bestelldatum ,p.oberkategorie ,count(1)
from uss_willibald.bridge_willibald 
join uss_willibald.produkt p  using (_key_produkt)
join uss_willibald.bestellung b using (_key_bestellung)
group by 1,2
order by 1,2