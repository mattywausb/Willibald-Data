create schema willibald_shop_p2;

CREATE TABLE willibald_shop_p2.Kunde (
    KundeID char(13)  NOT NULL ,
    VereinsPartnerID varchar(30)  NULL ,
    Vorname varchar(128)  NOT NULL ,
    Name varchar(128)  NOT NULL ,
    Geschlecht char  NULL ,
    Geburtsdatum date  NOT NULL ,
    Telefon varchar(20)  NULL ,
    Mobil varchar(20)  NULL ,
    Email varchar(128)  NULL ,
    Kreditkarte varchar(30)  NOT NULL ,
    GueltigBis char(5)  NOT NULL ,
    KKFirma varchar(128)  NOT NULL
);

CREATE TABLE willibald_shop_p2.Wohnort (
    KundeID char(13)  NOT NULL ,
    Von date  NOT NULL ,
    Bis date  NULL ,
    Strasse varchar(128)  NOT NULL ,
    Hausnummer varchar(10)  NOT NULL ,
    Adresszusatz varchar(128)  NULL ,
    Plz varchar(10)  NOT NULL ,
    Ort varchar(128)  NOT NULL ,
    Land varchar(128)  NULL
);

CREATE TABLE willibald_shop_p2.Lieferadresse (
    LieferAdrID int  NOT NULL ,
    KundeID char(13)  NOT NULL ,
    Strasse varchar(128)  NOT NULL ,
    Hausnummer varchar(10)  NOT NULL ,
    Adresszusatz varchar(128)  NULL ,
    Plz varchar(10)  NOT NULL ,
    Ort varchar(128)  NOT NULL ,
    Land varchar(128)  NULL
);

CREATE TABLE willibald_shop_p2.VereinsPartner (
    VereinsPartnerID varchar(30)  NOT NULL ,
    KundeIDVerein char(13)  NOT NULL ,
    Rabatt1 int  NOT NULL ,
    Rabatt2 int  NOT NULL ,
    Rabatt3 int  NOT NULL
);

CREATE TABLE willibald_shop_p2.Kategorie (
    KatID varchar(50)  NOT NULL ,
    OberKatID varchar(50)  NULL ,
    Name varchar(512)  NOT NULL
);

CREATE TABLE willibald_shop_p2.Produkt (
    ProduktID int  NOT NULL ,
    KatID varchar(50)  NOT NULL ,
    Bezeichnung varchar(512)  NOT NULL ,
    Umfang varchar(128)  NOT NULL ,
    Typ int  NOT NULL ,
    Preis decimal(5,2)  NOT NULL ,
    Pflanzort varchar(128)  NOT NULL ,
    Pflanzabstand varchar(128)  NOT NULL
);

CREATE TABLE willibald_shop_p2.Bestellung (
    BestellungID bigint  NOT NULL ,
    KundeID char(13)  NOT NULL ,
    AllgLieferAdrID int  NOT NULL ,
    Bestelldatum date  NOT NULL ,
    Wunschdatum date  NOT NULL ,
    Rabatt numeric(5,2)  NOT NULL
);

CREATE TABLE willibald_shop_p2.Position (
    BestellungID bigint  NOT NULL ,
    PosID bigint  NOT NULL ,
    ProduktID int  NOT NULL ,
    SpezLieferAdrID int  NULL ,
    Menge int  NOT NULL ,
    Preis numeric(10,2)  NOT NULL
);

CREATE TABLE willibald_shop_p2.Lieferung (
    BestellungID bigint  NOT NULL ,
    PosID bigint  NOT NULL ,
    LieferAdrID int  NOT NULL ,
    LieferDienstID varchar(30)  NOT NULL ,
    LieferDatum date  NOT NULL
);

CREATE TABLE willibald_shop_p2.LieferDienst (
    LieferDienstID varchar(30)  NOT NULL ,
    Name varchar(128)  NOT NULL ,
    Telefon varchar(20)  NOT NULL ,
    Fax varchar(20)  NULL ,
    Email varchar(128)  NOT NULL ,
    Strasse varchar(128)  NOT NULL ,
    Hausnummer varchar(10)  NOT NULL ,
    Plz varchar(10)  NOT NULL ,
    Ort varchar(128)  NOT NULL ,
    Land varchar(128)  NULL
);

