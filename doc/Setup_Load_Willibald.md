# Willibald source system - Database installation guide

## Intention 
Willibald  source database is needed for several cimt scenarios. But manual installation is very complex


## Development Goal
A python script is needed for an installation at the press of a button.


## Prerequisites

### Target Database 
- The script should work for Snowflake and PostgreSQL.

### DDL compatibility
- DDLs should work with PostgreSQL and Snowflake as well (ANSI DDL)

### Loading 
- CSV Bulk Load needed for fast loading
- Reference CSV data should also be loaded

### Willibald sources
- Existing source DDLs and CSV files should not be touched, new DDLs with postfix _ANSI.sql should be created

### Configuration
- DB Connection, Schemata and file directories should be outsourced in separate config file

### Data delivery periods
6 schemas for the tables to be load:
 -  3 data delivery schemas for Webshop and 
 -  3 data delivery schemas for Roadshow 

2 schemas for the views pointing to the current day/period tables:
 -  1 schema for Webshop and
 -  1 schema for Roadshow 
  
![Schema_picture](Grafik/schemas.png)

### Cleanup
- all schema has to be dropped before creation and loading (cleanup) 

### CSV File - Table mapping
- not all CSV files has the same name as the tables to be loaded, mapping needed

### Date an number formats in CSV files
- german date format in CSV has to be interpreted in the correct format
- german decimal separator in CSV files must be  in the correct format

### Logging
- executed sql  has to be logged in terminal 

### Encoding
- CSV file encoding of UTF-8-BOM has be interpreted in the right way


# New created files and folders
- Willibald-Data / Load_Willibald_PostgreSQL.py
- Willibald-Data / Load_Willibald_Snowflake.py
- Willibald-Data / doc / Setup_Load_Willbald.md
- Willibald-Data / Grafik / schemas.md
- Willibald-Data / config_template / db_postgresql_config.json
- Willibald-Data / config_template / db_snowflake_config.json
- Willibald-Data / config_template / folder_config.json
- Willibald-Data / config_template / schemas_config.json
- Willibald-Data / config /
- Willibald-Data / Webshop / Testdaten Periode 1 / _Testdaten_DDL_ANSI.sql
- Willibald-Data / Webshop / Testdaten Periode 1 / _Testdaten_DDL_1_ANSI.sql
- Willibald-Data / Webshop / Testdaten Periode 1 / kategorie_DDL_ANSI.sql
- Willibald-Data / Webshop / Testdaten Periode 1 / produkt_typ_DDL_ANSI.sql
- Willibald-Data / Webshop / Testdaten Periode 1 / termintreue_DDL_ANSI.sql
- Willibald-Data / Webshop / Testdaten Periode 2 / _Testdaten_DDL_2_ANSI.sql
- Willibald-Data / Webshop / Testdaten Periode 2 / kategorie_DDL_ANSI.sql
- Willibald-Data / Webshop / Testdaten Periode 2 / termintreue_DDL_ANSI.sql
- Willibald-Data / Webshop / Testdaten Periode 3 / _Testdaten_DDL_3_ANSI.sql
- Willibald-Data / Webshop / Testdaten Periode 3 / kategorie_DDL_ANSI.sql
- Willibald-Data / Roadshow / Tag 1 / _Roadshow_DDL_1_ANSI.sql
- Willibald-Data / Roadshow / Tag 1 / _Roadshow_DDL_ANSI.sql
- Willibald-Data / Roadshow / Tag 2 / _Roadshow_DDL_2_ANSI.sql
- Willibald-Data / Roadshow / Tag 3 / _Roadshow_DDL_3_ANSI.sql


1. Copy config files from 
   Willibald-Data / config_template -> Willibald-Data / config 
   
2. Add or modify values to  your environment values
   - connection for Snowflake (db_snowflake_config.json)
   - connection for Postgresql (db_postgresql_config.json)
   - folder (folder_config.json)
   - schema (schemas_config.json)
   
3. run python script
   
   - Snowflake  (Willibald-Data / Load_Willibald_Snowflake.py)
   - Postgresql (Willibald-Data / Load_Willibald_PostgreSQL.py)

