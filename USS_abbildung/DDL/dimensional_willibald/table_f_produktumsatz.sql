
-- DROP TABLE dimensional_willibald.f_produktumsatz;

CREATE TABLE dimensional_willibald.f_produktumsatz (
	md_inserted_at timestamp default current_timestamp
	,_dk_bestellung numeric(20)
	,_dk_kunde varchar(13)
	,_dk_lieferdienst varchar(30)
	,_dk_produkt numeric(10)
	,_dk_vereinspartner varchar(30)
	,ad_landing boolean
	,betrag_position numeric(10,2)
	,betrag_position_verrechnet numeric(10,2)
	,menge numeric(10)
	,posid numeric(20)
	,verkaufstag date
	,was_delivered boolean
);