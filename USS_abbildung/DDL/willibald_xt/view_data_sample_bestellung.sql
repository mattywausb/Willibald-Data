-- DROP view willibald_xt.data_sample_bestellung ;

CREATE or replace view willibald_xt.data_sample_bestellung as

with ranked_bestellung as (
select bestellungid, rank() over (partition by bestelldatum order by bestellungid) sample_rank
from willibald_shop_p1.bestellung
)
select bestellungid 
from ranked_bestellung
where sample_rank<=15
;


