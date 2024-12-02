-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- ANSI SQL does not support sp_rename, so we will skip these lines.

-- SET XACT_ABORT ON;

-- BEGIN TRANSACTION QUICKDBD;

-- CREATE SCHEMA WILLIBALD_WEBSHOP_P3;

-- SET DEFAULT SCHEMA WILLIBALD_WEBSHOP_P3;


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
    KKFirma VARCHAR(128) NOT NULL,
    CONSTRAINT PK_Kunde PRIMARY KEY (KundeID)
);

CREATE TABLE Wohnort (
    KundeID CHAR(13) NOT NULL,
    Von DATE NOT NULL,
    Bis DATE NULL,
    Strasse VARCHAR(128) NOT NULL,
    Hausnummer VARCHAR(10)  NULL,
    Adresszusatz VARCHAR(128) NULL,
    Plz VARCHAR(10) NOT NULL,
    Ort VARCHAR(128) NOT NULL,
    Land VARCHAR(128) NULL,
    CONSTRAINT PK_Wohnort PRIMARY KEY (KundeID, Von)
);

CREATE TABLE Lieferadresse (
    LieferAdrID NUMBER(38,0) NOT NULL,
    KundeID CHAR(13) NOT NULL,
    Strasse VARCHAR(128) NOT NULL,
    Hausnummer VARCHAR(10) NOT NULL,
    Adresszusatz VARCHAR(128) NULL,
    Plz VARCHAR(10) NOT NULL,
    Ort VARCHAR(128) NOT NULL,
    Land VARCHAR(128) NULL,
    CONSTRAINT PK_Lieferadresse PRIMARY KEY (LieferAdrID)
);

CREATE TABLE VereinsPartner (
    VereinsPartnerID VARCHAR(30) NOT NULL,
    KundeIDVerein CHAR(13) NOT NULL,
    Rabatt1 NUMBER(38,0) NOT NULL,
    Rabatt2 NUMBER(38,0) NOT NULL,
    Rabatt3 NUMBER(38,0) NOT NULL,
    CONSTRAINT PK_VereinsPartner PRIMARY KEY (VereinsPartnerID)
);

CREATE TABLE Kategorie (
    KatID VARCHAR(50) NOT NULL,
    OberKatID VARCHAR(50) NULL,
    Name VARCHAR(512) NOT NULL,
    CONSTRAINT PK_Kategorie PRIMARY KEY (KatID)
);

CREATE TABLE Produkt (
    ProduktID NUMBER(38,0) NOT NULL,
    KatID VARCHAR(50) NOT NULL,
    Bezeichnung VARCHAR(512) NOT NULL,
    Umfang VARCHAR(128) NOT NULL,
    Typ NUMBER(38,0) NOT NULL,
    Preis DECIMAL(5,2) NOT NULL,
    Pflanzort VARCHAR(128) NOT NULL,
    Pflanzabstand VARCHAR(128) NOT NULL,
    CONSTRAINT PK_Produkt PRIMARY KEY (ProduktID)
);

CREATE TABLE Bestellung (
    BestellungID BIGINT NOT NULL,
    KundeID CHAR(13) NOT NULL,
    AllgLieferAdrID NUMBER(38,0) NOT NULL,
    Bestelldatum DATE NOT NULL,
    Wunschdatum DATE NOT NULL,
    Rabatt NUMERIC(5,2) NOT NULL,
    CONSTRAINT PK_Bestellung PRIMARY KEY (BestellungID)
);

CREATE TABLE Position (
    BestellungID BIGINT NOT NULL,
    PosID BIGINT NOT NULL,
    ProduktID NUMBER(38,0) NOT NULL,
    SpezLieferAdrID NUMBER(38,0) NULL,
    Menge NUMBER(38,0) NOT NULL,
    Preis NUMERIC(10,2) NOT NULL,
    CONSTRAINT PK_Position PRIMARY KEY (BestellungID, PosID)
);

CREATE TABLE Lieferung (
    BestellungID BIGINT NOT NULL,
    PosID BIGINT NOT NULL,
    LieferAdrID NUMBER(38,0) NOT NULL,
    LieferDienstID VARCHAR(30) NOT NULL,
    LieferDatum DATE NOT NULL,
    CONSTRAINT PK_Lieferung PRIMARY KEY (BestellungID, PosID, LieferAdrID, LieferDienstID)
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
    Land VARCHAR(128) NULL,
    CONSTRAINT PK_LieferDienst PRIMARY KEY (LieferDienstID)
);

ALTER TABLE Kunde ADD CONSTRAINT FK_Kunde_VereinsPartnerID FOREIGN KEY (VereinsPartnerID) REFERENCES VereinsPartner (VereinsPartnerID);

ALTER TABLE Wohnort ADD CONSTRAINT FK_Wohnort_KundeID FOREIGN KEY (KundeID) REFERENCES Kunde (KundeID);

ALTER TABLE Lieferadresse ADD CONSTRAINT FK_Lieferadresse_KundeID FOREIGN KEY (KundeID) REFERENCES Kunde (KundeID);

ALTER TABLE VereinsPartner ADD CONSTRAINT FK_VereinsPartner_KundeIDVerein FOREIGN KEY (KundeIDVerein) REFERENCES Kunde (KundeID);

ALTER TABLE Kategorie ADD CONSTRAINT FK_Kategorie_OberKatID FOREIGN KEY (OberKatID) REFERENCES Kategorie (KatID);

ALTER TABLE Produkt ADD CONSTRAINT FK_Produkt_KatID FOREIGN KEY (KatID) REFERENCES Kategorie (KatID);

ALTER TABLE Bestellung ADD CONSTRAINT FK_Bestellung_KundeID FOREIGN KEY (KundeID) REFERENCES Kunde (KundeID);

ALTER TABLE Bestellung ADD CONSTRAINT FK_Bestellung_AllgLieferAdrID FOREIGN KEY (AllgLieferAdrID) REFERENCES Lieferadresse (LieferAdrID);

ALTER TABLE Position ADD CONSTRAINT FK_Position_BestellungID FOREIGN KEY (BestellungID) REFERENCES Bestellung (BestellungID);

ALTER TABLE Position ADD CONSTRAINT FK_Position_ProduktID FOREIGN KEY (ProduktID) REFERENCES Produkt (ProduktID);

ALTER TABLE Position ADD CONSTRAINT FK_Position_SpezLieferAdrID FOREIGN KEY (SpezLieferAdrID) REFERENCES Lieferadresse (LieferAdrID);

ALTER TABLE Lieferung ADD CONSTRAINT FK_Lieferung_BestellungID_PosID FOREIGN KEY (BestellungID, PosID) REFERENCES Position (BestellungID, PosID);

ALTER TABLE Lieferung ADD CONSTRAINT FK_Lieferung_LieferAdrID FOREIGN KEY (LieferAdrID) REFERENCES Lieferadresse (LieferAdrID);

ALTER TABLE Lieferung ADD CONSTRAINT FK_Lieferung_LieferDienstID FOREIGN KEY (LieferDienstID) REFERENCES LieferDienst (LieferDienstID);

-- COMMIT TRANSACTION QUICKDBD;
