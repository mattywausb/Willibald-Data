-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


-- CREATE SCHEMA WILLIBALD_ROADSHOW_T1;

-- SET DEFAULT SCHEMA WILLIBALD_ROADSHOW_T1;

CREATE OR REPLACE TABLE RS_Bestellung (
    BestellungID VARCHAR(128) NOT NULL,
    KundeID CHAR(13) NULL,
    VereinsPartnerID VARCHAR(30) NOT NULL,
    Kaufdatum DATE NOT NULL,
    Kreditkarte VARCHAR(30) NULL,
    GueltigBis CHAR(6) NULL,
    KKFirma VARCHAR(128) NULL,
    ProduktID INT NOT NULL,
    Menge INT NOT NULL,
    Preis NUMERIC(10,2) NOT NULL,
    Rabatt NUMERIC(5,2) NULL
);
