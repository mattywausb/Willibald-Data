-- DROP view willibald_xt.lieferung ;

CREATE or replace view willibald_xt.lieferung as

select l.*
	,mod (coalesce(plz+mod(lieferdienstid,5) ,0),13)*0.25+2 lieferkosten -- Mocking some costs by messing around with plx and lieferdienstid
from willibald_shop_p1.lieferung l
left join willibald_xt.lieferadresse la on la.lieferadrid =l.lieferadrid 
;

/*
 
 select plz,l.lieferdienstid ,max(lieferkosten ) lieferkosten
 from willibald_xt.lieferung l
 left join willibald_xt.lieferadresse la on la.lieferadrid =l.lieferadrid 
 group by 1,2
 order by 1,2

*/