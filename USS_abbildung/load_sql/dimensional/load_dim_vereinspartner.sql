
truncate DIMENSIONAL_WILLIBALD.DIM_VEREINSPARTNER;

INSERT INTO DIMENSIONAL_WILLIBALD.DIM_VEREINSPARTNER
(_DK_VEREINSPARTNER
, VEREINSPARTNERID
, RABATT1
, RABATT2
, RABATT3)
select 
	vereinspartnerid ,
	vereinspartnerid ,
	rabatt1 ,
	rabatt2 ,
	rabatt3 
from  willibald_xt.vereinspartner ;

/* 
 * select * from 	DIMENSIONAL_WILLIBALD.DIM_VEREINSPARTNER
 */