
truncate table DIMENSIONAL_WILLIBALD.DIM_KUNDE;

INSERT INTO DIMENSIONAL_WILLIBALD.DIM_KUNDE
( _DK_KUNDE
, KUNDEID
, VORNAME
, GESCHLECHT
, GEBURTSJAHR
, KREDITKARTENFIRMA)
select 
	kundeid ,
	kundeid ,
	vorname ,
	geschlecht ,
	year(geburtsdatum )geburtsjahr ,
	kkfirma
from  willibald_xt.kunde;

/*
	select * from  DIMENSIONAL_WILLIBALD.DIM_KUNDE
 */
