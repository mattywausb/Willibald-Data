
/* Abdeckung Kunden durch Bestellungen und umgekehrt */
select 
	bestellung.kundeid bestellung_kundeid
	, kunde.kundeid 
from willibald_shop_p1.bestellung
full outer join  willibald_shop_p1.kunde 
	on kunde.kundeid =bestellung.kundeid 
where kunde.kundeid is null 
or bestellung.kundeid is null;

bestellung_kundeid|kundeid      |
------------------+-------------+
899               |             |
                  |301          |


/* Positionen mit Produkt */                  
select count(1) row_count
	,count(produktid) usage_count
from willibald_shop_p1."position";                  

row_count|usage_count|
---------+-----------+
     2000|       2000|

/* Abdeckung produkte durch bestellpositionen und umgekehrt */
select 
	position.produktid position_produktid
	, produkt.produktid 
from willibald_shop_p1.position
full outer join  willibald_shop_p1.produkt  
	on position.produktid  =produkt.produktid 
where position.produktid  is null 
or produkt.produktid is null;

position_produktid|produktid|
------------------+---------+
                  |      120|
                  |       82|
                  |       18|
                  |       98|
                  |       15|
                  |      107|
                  |       68|
                  |       99|
                  |      122|
                  |      117|
                  |       74|
                  |       49|
                  |       70|
                  |       88|
                  
                  

/* Abdeckung Lieferadresse durch Bestellungen und umgekehrt */
select 
	bestellung.allglieferadrid  bestellung_allglieferadrid 
	,lieferadresse.lieferadrid 
from willibald_shop_p1.bestellung
full outer join  willibald_shop_p1.lieferadresse 
	on lieferadresse.lieferadrid =bestellung.allglieferadrid 
where bestellung.allglieferadrid  is null 
or lieferadresse.lieferadrid is null;

bestellung_allglieferadrid|lieferadrid|
--------------------------+-----------+
                          |     999999|
                          |     999998|
                          |     999997|
                          |     999996|
                          |     999995|
                          |     999994|
                          
/* nutzung speziallieferadresse durch positionen*/
select count(1) row_count
	,count(spezlieferadrid) usage_count
from willibald_shop_p1."position";

row_count|usage_count|
---------+-----------+
     2000|        300|


/* Lieferung mit Lieferdienst */                  
select count(1) row_count
	,count(lieferdienstid) usage_count
from willibald_shop_p1.lieferung;                  

row_count|usage_count|
---------+-----------+
     1951|       1951|
     
     

/* Abdeckung bestellpositionen zu lieferdiest und umgekehrt */
select 
	lieferdienst.lieferdienstid
	, lieferung.lieferdienstid lieferung_lieferdienstid
from willibald_shop_p1.lieferung 
full outer join  willibald_shop_p1.lieferdienst   
	on lieferdienst.lieferdienstid  =lieferung.lieferdienstid 
where lieferdienst.lieferdienstid  is null 
or lieferung.lieferdienstid  is null;

lieferdienstid|lieferung_lieferdienstid|
--------------+------------------------+
68            |                        |
32            |                        |
56            |                        |
62            |                        |
20            |                        |
23            |                        |
59            |                        |
50            |                        |
35            |                        |
53            |                        |
74            |                        |
5             |                        |
29            |                        |
14            |                        |
77            |                        |
80            |                        |
26            |                        |
47            |                        |
41            |                        |