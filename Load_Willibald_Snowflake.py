#pip install snowflake-connector-python


import snowflake.connector
import os

# Snowflake-Verbindungsinformationen
account = 'your_account'
user = 'your_username'
password = 'your_password'
warehouse = 'your_warehouse'
database = 'your_database'

# Verbindung zu Snowflake herstellen
conn = snowflake.connector.connect(
    user=user,
    password=password,
    account=account,
    warehouse=warehouse,
    database=database
)

# Funktion zum Erstellen eines Schemas
def create_schema(schema_name):
    cursor = conn.cursor()
    cursor.execute(f"CREATE SCHEMA IF NOT EXISTS {schema_name}")
    conn.commit()
    cursor.close()

# Funktion zum Ausführen eines SQL-Skripts
def execute_sql_file(file_path, schema_name):
    with open(file_path, 'r') as file:
        sql = file.read()
    cursor = conn.cursor()
    cursor.execute(f"USE SCHEMA {schema_name}")
    cursor.execute(sql)
    conn.commit()
    cursor.close()

# Funktion zum Laden einer CSV-Datei in Snowflake
def load_csv_to_snowflake(file_path, table_name, schema_name):
    cursor = conn.cursor()
    try:
        # Erstelle eine temporäre Stage
        stage_name = f"{table_name}_stage"
        cursor.execute(f"CREATE OR REPLACE TEMPORARY STAGE {stage_name}")

        # Lade die CSV-Datei in die temporäre Stage
        cursor.execute(f"PUT file://{file_path} @{stage_name}")

        # Lade die Daten aus der Stage in die Tabelle
        cursor.execute(f"""
            COPY INTO {schema_name}.{table_name}
            FROM @{stage_name}
            FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY='"')
        """)

        print(f"{file_path} erfolgreich in {table_name} geladen.")
    except Exception as e:
        print(f"Fehler beim Laden von {file_path} in {table_name}: {e}")
    finally:
        cursor.close()

# Funktion zum Erstellen eines Views
def create_view(view_name, table_name, source_schema, target_schema):
    cursor = conn.cursor()
    cursor.execute(f"USE SCHEMA {target_schema}")
    cursor.execute(f"""
        CREATE OR REPLACE VIEW {view_name} AS
        SELECT * FROM {source_schema}.{table_name}
    """)
    conn.commit()
    cursor.close()

# Schemata erstellen
schemas = [
    'WILLIBALD_WEBSHOP',
    'WILLIBALD_WEBSHOP_P1',
    'WILLIBALD_WEBSHOP_P2',
    'WILLIBALD_WEBSHOP_P3',
    'WILLIBALD_ROADSHOW',
    'WILLIBALD_ROADSHOW_T1',
    'WILLIBALD_ROADSHOW_T2',
    'WILLIBALD_ROADSHOW_T3'
]

for schema in schemas:
    create_schema(schema)

# SQL-Skripte und CSV-Dateien für WILLIBALD_WEBSHOP_P1
sql_files_p1 = [
    '/Willibald-Data/Webshop/Testdaten Periode 1/_Testdaten_DDL_1_ANSI.sql',
    '/Willibald-Data/Webshop/Testdaten Periode 1/Dubletten_ANSI.sql'
]

csv_files_p1 = [
    '/Willibald-Data/Webshop/Testdaten Periode 1/bestellung.csv',
    '/Willibald-Data/Webshop/Testdaten Periode 1/href_termintreue.csv',
    '/Willibald-Data/Webshop/Testdaten Periode 1/kunde.csv',
    '/Willibald-Data/Webshop/Testdaten Periode 1/lieferadresse.csv',
    '/Willibald-Data/Webshop/Testdaten Periode 1/lieferdienst.csv',
    '/Willibald-Data/Webshop/Testdaten Periode 1/Lieferung.csv',
    '/Willibald-Data/Webshop/Testdaten Periode 1/postition.csv',
    '/Willibald-Data/Webshop/Testdaten Periode 1/produkt.csv',
    '/Willibald-Data/Webshop/Testdaten Periode 1/produktkategorie.csv',
    '/Willibald-Data/Webshop/Testdaten Periode 1/ref_produkt_typ.csv',
    '/Willibald-Data/Webshop/Testdaten Periode 1/vereinspartner.csv',
    '/Willibald-Data/Webshop/Testdaten Periode 1/wohnort.csv'
]

for sql_file in sql_files_p1:
    execute_sql_file(sql_file, 'WILLIBALD_WEBSHOP_P1')

for csv_file in csv_files_p1:
    table_name = os.path.splitext(os.path.basename(csv_file))[0]
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_WEBSHOP_P1')

# SQL-Skripte und CSV-Dateien für WILLIBALD_WEBSHOP_P2
sql_files_p2 = [
    '/Willibald-Data/Webshop/Testdaten Periode 2/_Testdaten_DDL_P2_ANSI.sql'
]

csv_files_p2 = [
    '/willibald-data/Webshop/Testdaten Periode 2/bestellung.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/href_termintreue.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/kunde.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/lieferadresse.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/lieferdienst.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/Lieferung.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/postition.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/produkt.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/produktkategorie.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/vereinspartner.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/wohnort.csv'
]

for sql_file in sql_files_p2:
    execute_sql_file(sql_file, 'WILLIBALD_WEBSHOP_P2')

for csv_file in csv_files_p2:
    table_name = os.path.splitext(os.path.basename(csv_file))[0]
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_WEBSHOP_P2')

# SQL-Skripte und CSV-Dateien für WILLIBALD_WEBSHOP_P3
sql_files_p3 = [
    '/Willibald-Data/Webshop/Testdaten Periode 3/_Testdaten_DDL_P3_ANSI.sql'
]

csv_files_p3 = [
    '/willibald-data/Webshop/Testdaten Periode 3/bestellung.csv',
    '/willibald-data/Webshop/Testdaten Periode 3/kunde.csv',
    '/willibald-data/Webshop/Testdaten Periode 3/lieferadresse.csv',
    '/willibald-data/Webshop/Testdaten Periode 3/lieferdienst.csv',
    '/willibald-data/Webshop/Testdaten Periode 3/Lieferung.csv',
    '/willibald-data/Webshop/Testdaten Periode 3/postition.csv',
    '/willibald-data/Webshop/Testdaten Periode 3/produkt.csv',
    '/willibald-data/Webshop/Testdaten Periode 3/produktkategorie.csv',
    '/willibald-data/Webshop/Testdaten Periode 3/vereinspartner.csv',
    '/willibald-data/Webshop/Testdaten Periode 3/wohnort.csv'
]

for sql_file in sql_files_p3:
    execute_sql_file(sql_file, 'WILLIBALD_WEBSHOP_P3')

for csv_file in csv_files_p3:
    table_name = os.path.splitext(os.path.basename(csv_file))[0]
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_WEBSHOP_P3')

# SQL-Skripte und CSV-Dateien für WILLIBALD_ROADSHOW_T1
sql_files_t1 = [
    '/willibald-data/Roadshow/Tag 1/_Roadshow_DDL_ANSI.sql',
    '/willibald-data/Roadshow/Tag 1/_Roadshow_DDL_1_ANSI.sql'
]

csv_files_t1 = [
    '/willibald-data/Roadshow/Tag 1/RS_Bestellung.csv'
]

for sql_file in sql_files_t1:
    execute_sql_file(sql_file, 'WILLIBALD_ROADSHOW_T1')

for csv_file in csv_files_t1:
    table_name = os.path.splitext(os.path.basename(csv_file))[0]
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_ROADSHOW_T1')

# SQL-Skripte und CSV-Dateien für WILLIBALD_ROADSHOW_T2
sql_files_t2 = [
    '/willibald-data/Roadshow/Tag 2/_Roadshow_DDL_ANSI.sql'
]

csv_files_t2 = [
    '/willibald-data/Roadshow/Tag 2/RS_Bestellung.csv'
]

for sql_file in sql_files_t2:
    execute_sql_file(sql_file, 'WILLIBALD_ROADSHOW_T2')

for csv_file in csv_files_t2:
    table_name = os.path.splitext(os.path.basename(csv_file))[0]
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_ROADSHOW_T2')

# SQL-Skripte und CSV-Dateien für WILLIBALD_ROADSHOW_T3
sql_files_t3 = [
    '/willibald-data/Roadshow/Tag 3/_Roadshow_DDL_ANSI.sql'
]

csv_files_t3 = [
    '/willibald-data/Roadshow/Tag 3/RS_Bestellung.csv'
]

for sql_file in sql_files_t3:
    execute_sql_file(sql_file, 'WILLIBALD_ROADSHOW_T3')

for csv_file in csv_files_t3:
    table_name = os.path.splitext(os.path.basename(csv_file))[0]
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_ROADSHOW_T3')

# Views im Schema WILLIBALD_WEBSHOP erstellen
tables_p1 = [
    'bestellung',
    'href_termintreue',
    'kunde',
    'lieferadresse',
    'lieferdienst',
    'Lieferung',
    'postition',
    'produkt',
    'produktkategorie',
    'ref_produkt_typ',
    'vereinspartner',
    'wohnort'
]

for table in tables_p1:
    create_view(table, table, 'WILLIBALD_WEBSHOP_P1', 'WILLIBALD_WEBSHOP')

# Views im Schema WILLIBALD_ROADSHOW erstellen
tables_t1 = [
    'RS_Bestellung'
]

for table in tables_t1:
    create_view(table, table, 'WILLIBALD_ROADSHOW_T1', 'WILLIBALD_ROADSHOW')

# Verbindung schließen
conn.close()

