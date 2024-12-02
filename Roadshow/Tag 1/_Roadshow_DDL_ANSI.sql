-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- SET XACT_ABORT ON;

-- BEGIN TRANSACTION QUICKDBD;

-- CREATE SCHEMA WILLIBALD_ROADSHOW_T1;

-- SET DEFAULT SCHEMA WILLIBALD_ROADSHOW_T1;

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

CREATE TABLE VereinsPartner (
    VereinsPartnerID VARCHAR(30) NOT NULL,
    KundeIDVerein CHAR(13) NOT NULL,
    Rabatt1 INT NOT NULL,
    Rabatt2 INT NOT NULL,
    Rabatt3 INT NOT NULL,
    CONSTRAINT PK_VereinsPartner PRIMARY KEY (VereinsPartnerID)
);

CREATE TABLE Produkt (
    ProduktID INT NOT NULL,
    KatID VARCHAR(50) NOT NULL,
    Bezeichnung VARCHAR(512) NOT NULL,
    Umfang VARCHAR(128) NOT NULL,
    Typ INT NOT NULL,
    Preis DECIMAL(5,2) NOT NULL,
    Pflanzort VARCHAR(128) NOT NULL,
    Pflanzabstand VARCHAR(128) NOT NULL,
    CONSTRAINT PK_Produkt PRIMARY KEY (ProduktID)
);

CREATE TABLE Bestellung (
    BestellungID VARCHAR(128) NOT NULL,
    KundeID CHAR(13) NULL,
    VereinsPartnerID VARCHAR(30) NOT NULL,
    Kaufdatum DATE NOT NULL,
    Kreditkarte VARCHAR(30) NULL,
    GueltigBis CHAR(5) NULL,
    KKFirma VARCHAR(128) NULL,
    ProduktID INT NOT NULL,
    Menge INT NOT NULL,
    Preis NUMERIC(10,2) NOT NULL,
    Rabatt NUMERIC(5,2) NULL,
    CONSTRAINT PK_Bestellung PRIMARY KEY (BestellungID)
);

ALTER TABLE Kunde ADD CONSTRAINT FK_Kunde_VereinsPartnerID FOREIGN KEY (VereinsPartnerID) REFERENCES VereinsPartner (VereinsPartnerID);

ALTER TABLE VereinsPartner ADD CONSTRAINT FK_VereinsPartner_KundeIDVerein FOREIGN KEY (KundeIDVerein) REFERENCES Kunde (KundeID);

ALTER TABLE Bestellung ADD CONSTRAINT FK_Bestellung_KundeID FOREIGN KEY (KundeID) REFERENCES Kunde (KundeID);

ALTER TABLE Bestellung ADD CONSTRAINT FK_Bestellung_VereinsPartnerID FOREIGN KEY (VereinsPartnerID) REFERENCES VereinsPartner (VereinsPartnerID);

ALTER TABLE Bestellung ADD CONSTRAINT FK_Bestellung_ProduktID FOREIGN KEY (ProduktID) REFERENCES Produkt (ProduktID);

-- COMMIT TRANSACTION QUICKDBD;
