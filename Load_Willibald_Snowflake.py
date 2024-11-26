import json
import os
import snowflake.connector

# Funktion zum Erstellen eines Schemas
def create_schema(schema_name):
    cursor = conn.cursor()
    cursor.execute(f"CREATE SCHEMA IF NOT EXISTS {schema_name}")
    conn.commit()
    cursor.close()

# Funktion zum Ausf�hren eines SQL-Skripts
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
        # Erstelle eine tempor�re Stage
        stage_name = f"{table_name}_stage"
        cursor.execute(f"CREATE OR REPLACE TEMPORARY STAGE {stage_name}")

        # Lade die CSV-Datei in die tempor�re Stage
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




# Konfigurationsdateien laden
with open('config/config.json', 'r') as file:
    config = json.load(file)

with open('config/folders_config.json', 'r') as file:
    folders_config = json.load(file)

with open('config/schemas_config.json', 'r') as file:
    schemas_config = json.load(file)

# Verbindungsinformationen aus der Konfigurationsdatei lesen
account = config['SNOWFLAKE_ACCOUNT']
user = config['SNOWFLAKE_USER']
password = config['SNOWFLAKE_PASSWORD']
warehouse = config['SNOWFLAKE_WAREHOUSE']
database = config['SNOWFLAKE_DATABASE']

# Verbindung zu Snowflake herstellen
conn = snowflake.connector.connect(
    user=user,
    password=password,
    account=account,
    warehouse=warehouse,
    database=database
)

# Schemata erstellen
schemas = schemas_config['schemas']

for schema in schemas:
    create_schema(schema)

# SQL-Skripte und CSV-Dateien f�r WILLIBALD_WEBSHOP_P1
sql_files_p1 = [
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], '_Testdaten_DDL_1_ANSI.sql'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'Dubletten_ANSI.sql')
]

csv_files_p1 = [
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'bestellung.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'href_termintreue.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'kunde.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'lieferadresse.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'lieferdienst.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'Lieferung.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'postition.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'produkt.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'produktkategorie.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'ref_produkt_typ.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'vereinspartner.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'wohnort.csv')
]

for sql_file in sql_files_p1:
    execute_sql_file(sql_file, 'WILLIBALD_WEBSHOP_P1')

for csv_file in csv_files_p1:
    table_name = os.path.splitext(os.path.basename(csv_file))[0]
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_WEBSHOP_P1')

# SQL-Skripte und CSV-Dateien f�r WILLIBALD_WEBSHOP_P2
sql_files_p2 = [
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], '_Testdaten_DDL_P2_ANSI.sql')
]

csv_files_p2 = [
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'bestellung.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'href_termintreue.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'kunde.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'lieferadresse.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'lieferdienst.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'Lieferung.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'postition.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'produkt.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'produktkategorie.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'vereinspartner.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'wohnort.csv')
]

for sql_file in sql_files_p2:
    execute_sql_file(sql_file, 'WILLIBALD_WEBSHOP_P2')

for csv_file in csv_files_p2:
    table_name = os.path.splitext(os.path.basename(csv_file))[0]
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_WEBSHOP_P2')

# SQL-Skripte und CSV-Dateien f�r WILLIBALD_WEBSHOP_P3
sql_files_p3 = [
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], '_Testdaten_DDL_P3_ANSI.sql')
]

csv_files_p3 = [
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'bestellung.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'kunde.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'lieferadresse.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'lieferdienst.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'Lieferung.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'postition.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'produkt.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'produktkategorie.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'vereinspartner.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'wohnort.csv')
]

for sql_file in sql_files_p3:
    execute_sql_file(sql_file, 'WILLIBALD_WEBSHOP_P3')

for csv_file in csv_files_p3:
    table_name = os.path.splitext(os.path.basename(csv_file))[0]
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_WEBSHOP_P3')

# SQL-Skripte und CSV-Dateien f�r WILLIBALD_ROADSHOW_T1
sql_files_t1 = [
    os.path.join(folders_config['ROADSHOW_TAG_1'], '_Roadshow_DDL_ANSI.sql'),
    os.path.join(folders_config['ROADSHOW_TAG_1'], '_Roadshow_DDL_1_ANSI.sql')
]

csv_files_t1 = [
    os.path.join(folders_config['ROADSHOW_TAG_1'], 'RS_Bestellung.csv')
]

for sql_file in sql_files_t1:
    execute_sql_file(sql_file, 'WILLIBALD_ROADSHOW_T1')

for csv_file in csv_files_t1:
    table_name = os.path.splitext(os.path.basename(csv_file))[0]
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_ROADSHOW_T1')

# SQL-Skripte und CSV-Dateien f�r WILLIBALD_ROADSHOW_T2
sql_files_t2 = [
    os.path.join(folders_config['ROADSHOW_TAG_2'], '_Roadshow_DDL_ANSI.sql')
]

csv_files_t2 = [
    os.path.join(folders_config['ROADSHOW_TAG_2'], 'RS_Bestellung.csv')
]

for sql_file in sql_files_t2:
    execute_sql_file(sql_file, 'WILLIBALD_ROADSHOW_T2')

for csv_file in csv_files_t2:
    table_name = os.path.splitext(os.path.basename(csv_file))[0]
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_ROADSHOW_T2')

# SQL-Skripte und CSV-Dateien f�r WILLIBALD_ROADSHOW_T3
sql_files_t3 = [
    os.path.join(folders_config['ROADSHOW_TAG_3'], '_Roadshow_DDL_ANSI.sql')
]

csv_files_t3 = [
    os.path.join(folders_config['ROADSHOW_TAG_3'], 'RS_Bestellung.csv')
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

# Verbindung schlie�en
conn.close()
