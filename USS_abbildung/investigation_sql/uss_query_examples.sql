select b.bestelldatum ,k.geschlecht ,count(1)
from uss_willibald.bridge_willibald 
join uss_willibald.kunde k using (_key_kunde)
join uss_willibald.bestellung b using (_key_bestellung)
where stage='bestellung'
group by 1,2
order by 1,2