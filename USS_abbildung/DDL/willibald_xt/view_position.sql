-- DROP view willibald_xt.position ;

CREATE or replace view willibald_xt.position as

select
	p.*
	,(l.posid is not null) as was_delivered  -- derived from  delivery data (see join below)
	,(mod(p.bestellungid+p.posid,17)<4) as ad_landing  -- mock ad_landing data with some procedural randomnes 
from willibald_shop_p1.position p
left join WILLIBALD_SHOP_P1.LIEFERUNG l on l.bestellungid =p.bestellungid and l.posid =p.posid;

;


