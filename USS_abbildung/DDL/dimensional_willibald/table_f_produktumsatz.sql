
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
alter table dimensional_willibald.dim_bestellung add constraint FK_bestellung FOREIGN KEY(_dk_bestellung) references dimensional_willibald.dim_bestellung(_dk_bestellung);
alter table dimensional_willibald.dim_kunde add constraint FK_kunde FOREIGN KEY(_dk_kunde) references dimensional_willibald.dim_kunde(_dk_kunde);
alter table dimensional_willibald.dim_vereinspartner add constraint FK_vereinspartner FOREIGN KEY(_dk_vereinspartner) references dimensional_willibald.dim_vereinspartner(_dk_vereinspartner);
alter table dimensional_willibald.dim_produkt add constraint FK_produkt FOREIGN KEY(_dk_produkt) references dimensional_willibald.dim_produkt(_dk_produkt);
