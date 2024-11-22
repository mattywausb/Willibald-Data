-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

SET XACT_ABORT ON;

BEGIN TRANSACTION QUICKDBD;

create schema willibald_webshop_p1;

set default schema willibald_webshop_p1;

CREATE TABLE Kunde (
    KundeID CHAR(13) NOT NULL,
    VereinsPartnerID VARCHAR(30) NULL,
    Vorname VARCHAR(128) NOT NULL,
    Name VARCHAR(128) NOT NULL,
    Geschlecht CHAR NULL,
    Geburtsdatum DATE NOT NULL,
    Telefon VARCHAR(20) NULL,
    Mobil VARCHAR(20) NULL,
    Email VARCHAR(128) NULL,
    Kreditkarte VARCHAR(30) NOT NULL,
    GueltigBis CHAR(5) NOT NULL,
    KKFirma VARCHAR(128) NOT NULL
);

CREATE TABLE Wohnort (
    KundeID CHAR(13) NOT NULL,
    Von DATE NOT NULL,
    Bis DATE NULL,
    Strasse VARCHAR(128) NOT NULL,
    Hausnummer VARCHAR(10) NOT NULL,
    Adresszusatz VARCHAR(128) NULL,
    Plz VARCHAR(10) NOT NULL,
    Ort VARCHAR(128) NOT NULL,
    Land VARCHAR(128) NULL
);

CREATE TABLE Lieferadresse (
    LieferAdrID INT NOT NULL,
    KundeID CHAR(13) NOT NULL,
    Strasse VARCHAR(128) NOT NULL,
    Hausnummer VARCHAR(10) NOT NULL,
    Adresszusatz VARCHAR(128) NULL,
    Plz VARCHAR(10) NOT NULL,
    Ort VARCHAR(128) NOT NULL,
    Land VARCHAR(128) NULL
);

CREATE TABLE VereinsPartner (
    VereinsPartnerID VARCHAR(30) NOT NULL,
    KundeIDVerein CHAR(13) NOT NULL,
    Rabatt1 INT NOT NULL,
    Rabatt2 INT NOT NULL,
    Rabatt3 INT NOT NULL
);

CREATE TABLE Kategorie (
    KatID VARCHAR(50) NOT NULL,
    OberKatID VARCHAR(50) NULL,
    Name VARCHAR(512) NOT NULL
);

CREATE TABLE Produkt (
    ProduktID INT NOT NULL,
    KatID VARCHAR(50) NOT NULL,
    Bezeichnung VARCHAR(512) NOT NULL,
    Umfang VARCHAR(128) NOT NULL,
    Typ INT NOT NULL,
    Preis DECIMAL(5,2) NOT NULL,
    Pflanzort VARCHAR(128) NOT NULL,
    Pflanzabstand VARCHAR(128) NOT NULL
);

CREATE TABLE Bestellung (
    BestellungID BIGINT NOT NULL,
    KundeID CHAR(13) NOT NULL,
    AllgLieferAdrID INT NOT NULL,
    Bestelldatum DATE NOT NULL,
    Wunschdatum DATE NOT NULL,
    Rabatt NUMERIC(5,2) NOT NULL
);

CREATE TABLE Position (
    BestellungID BIGINT NOT NULL,
    PosID BIGINT NOT NULL,
    ProduktID INT NOT NULL,
    SpezLieferAdrID INT NULL,
    Menge INT NOT NULL,
    Preis NUMERIC(10,2) NOT NULL
);

CREATE TABLE Lieferung (
    BestellungID BIGINT NOT NULL,
    PosID BIGINT NOT NULL,
    LieferAdrID INT NOT NULL,
    LieferDienstID VARCHAR(30) NOT NULL,
    LieferDatum DATE NOT NULL
);

CREATE TABLE LieferDienst (
    LieferDienstID VARCHAR(30) NOT NULL,
    Name VARCHAR(128) NOT NULL,
    Telefon VARCHAR(20) NOT NULL,
    Fax VARCHAR(20) NULL,
    Email VARCHAR(128) NOT NULL,
    Strasse VARCHAR(128) NOT NULL,
    Hausnummer VARCHAR(10) NOT NULL,
    Plz VARCHAR(10) NOT NULL,
    Ort VARCHAR(128) NOT NULL,
    Land VARCHAR(128) NULL
);

COMMIT TRANSACTION QUICKDBD;
