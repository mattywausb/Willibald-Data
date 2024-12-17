-- DROP view willibald_xt.produkt ;

CREATE or replace view willibald_xt.produkt as

select pd.*
	,case when left(katid,3)='GSt' then 15000
		when left(katid,3)='GSc' then 10800
		when left(katid,2)='GM' then 22000
		ELSE 5000
	 end 						werbebudget   -- just make up some Budget, depedning on KatID
from  willibald_shop_p1.produkt pd

;


