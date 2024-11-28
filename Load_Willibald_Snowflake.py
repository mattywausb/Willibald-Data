import json
import os
import snowflake.connector
import csv

# Wrapper-Funktion für die execute-Methode des Cursors
def log_and_execute(cursor, query):
    print(f"Executing SQL: {query}")
    cursor.execute(query)

# Funktion zum Erstellen eines Schemas
def create_schema(schema_name):
    cursor = conn.cursor()
    log_and_execute(cursor, f"CREATE SCHEMA IF NOT EXISTS {schema_name}")
    conn.commit()
    cursor.close()

# Funktion zum Ausführen mehrerer SQL-Anweisungen
def execute_sql_commands(sql_commands, schema_name):
    cursor = conn.cursor()
    try:
        log_and_execute(cursor, f"USE SCHEMA {schema_name}")
        for command in sql_commands:
            command = command.strip()
            if command and not command.startswith('--'):  # Nur nicht-leere Befehle und keine Kommentare ausführen
                log_and_execute(cursor, command)
        conn.commit()
    except Exception as e:
        print(f"Fehler beim Ausführen der SQL-Anweisungen: {e}")
    finally:
        cursor.close()

# Funktion zum Anpassen der CSV-Datei
def adjust_csv(file_path, temp_file_path):
    with open(file_path, 'r', newline='', encoding='utf-8') as infile, open(temp_file_path, 'w', newline='', encoding='utf-8') as outfile:
        reader = csv.reader(infile, delimiter=';')
        writer = csv.writer(outfile, delimiter=';')
        for row in reader:
            new_row = []
            for item in row:
                # Dezimaltrenner ',' durch '.' ersetzen und Tausendertrennzeichen '.' entfernen
                item = item.replace(',', '.').replace('.', '')
                new_row.append(item)
            writer.writerow(new_row)

# Funktion zum Laden einer CSV-Datei in Snowflake
def load_csv_to_snowflake(file_path, table_name, schema_name):
    if not os.path.exists(file_path):
        print(f"Fehler: Die Datei {file_path} wurde nicht gefunden.")
        return

    # Temporäre Datei erstellen
    temp_file_path = file_path + '.tmp'
    adjust_csv(file_path, temp_file_path)

    cursor = conn.cursor()
    try:
        log_and_execute(cursor, f"USE SCHEMA {schema_name}")
        # Erstelle eine temporäre Stage
        stage_name = f"{table_name}_stage"
        log_and_execute(cursor, f"CREATE OR REPLACE TEMPORARY STAGE {stage_name}")

        # Lade die CSV-Datei in die temporäre Stage
        log_and_execute(cursor, f"PUT 'file://{temp_file_path}' @{stage_name}")

        # Lade die Daten aus der Stage in die Tabelle
        log_and_execute(cursor, f"""
            COPY INTO {schema_name}.{table_name}
            FROM @{stage_name}
            FILE_FORMAT = (
                TYPE = 'CSV',
                FIELD_OPTIONALLY_ENCLOSED_BY = '"',
                FIELD_DELIMITER = ';',
                DATE_FORMAT = 'DDMMYYYY',
                SKIP_HEADER = 1
            )
        """)

        print(f"{file_path} erfolgreich in {table_name} geladen.")
    except Exception as e:
        print(f"Fehler beim Laden von {file_path} in {table_name}: {e}")
    finally:
        cursor.close()
        # Temporäre Datei löschen
        os.remove(temp_file_path)

# Funktion zum Erstellen eines Views
def create_view(view_name, table_name, source_schema, target_schema):
    cursor = conn.cursor()
    log_and_execute(cursor, f"USE SCHEMA {target_schema}")
    log_and_execute(cursor, f"""
        CREATE OR REPLACE VIEW {view_name} AS
        SELECT * FROM {source_schema}.{table_name}
    """)
    conn.commit()
    cursor.close()

# Konfigurationsdateien laden
with open('config/db_config.json', 'r') as file:
    db_config = json.load(file)

with open('config/folders_config.json', 'r') as file:
    folders_config = json.load(file)

with open('config/schemas_config.json', 'r') as file:
    schemas_config = json.load(file)

# Verbindungsinformationen aus der Konfigurationsdatei lesen
account = db_config['SNOWFLAKE_ACCOUNT']
user = db_config['SNOWFLAKE_USER']
password = db_config['SNOWFLAKE_PASSWORD']
warehouse = db_config['SNOWFLAKE_WAREHOUSE']
database = db_config['SNOWFLAKE_DATABASE']

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




# SQL-Skripte und CSV-Dateien für WILLIBALD_WEBSHOP_P1
sql_files_p1 = [
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], '_Testdaten_DDL_1_ANSI.sql'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'termintreue_DDL_ANSI.sql'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'produkt_typ_DDL_ANSI.sql'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'Dubletten_ANSI.sql')
]

csv_files_p1 = [
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'bestellung.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'href_termintreue.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'kunde.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'lieferadresse.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'lieferdienst.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'Lieferung.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'position.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'produkt.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'produktkategorie.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'ref_produkt_typ.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'vereinspartner.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_1'], 'wohnort.csv')
]

# Zuordnung von CSV-Dateinamen zu Tabellennamen
csv_to_table_mapping = {
    'href_termintreue.csv': 'termintreue',
    'ref_produkt_typ.csv': 'produkt_typ',
    'produktkategorie.csv': 'kategorie'
}

for sql_file in sql_files_p1:
    with open(sql_file, 'r') as file:
        sql_commands = file.read().split(';')
    execute_sql_commands(sql_commands, 'WILLIBALD_WEBSHOP_P1')

for csv_file in csv_files_p1:
    table_name = csv_to_table_mapping.get(os.path.basename(csv_file), os.path.splitext(os.path.basename(csv_file))[0])
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_WEBSHOP_P1')






# SQL-Skripte und CSV-Dateien für WILLIBALD_WEBSHOP_P2
sql_files_p2 = [
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'termintreue_DDL_ANSI.sql'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], '_Testdaten_DDL_P2_ANSI.sql')
]

csv_files_p2 = [
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'bestellung.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'href_termintreue.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'kunde.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'lieferadresse.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'lieferdienst.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'Lieferung.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'position.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'produkt.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'produktkategorie.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'vereinspartner.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_2'], 'wohnort.csv')
]

for sql_file in sql_files_p2:
    with open(sql_file, 'r') as file:
        sql_commands = file.read().split(';')
    execute_sql_commands(sql_commands, 'WILLIBALD_WEBSHOP_P2')

for csv_file in csv_files_p2:
    table_name = csv_to_table_mapping.get(os.path.basename(csv_file), os.path.splitext(os.path.basename(csv_file))[0])
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_WEBSHOP_P2')





# SQL-Skripte und CSV-Dateien für WILLIBALD_WEBSHOP_P3
sql_files_p3 = [
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], '_Testdaten_DDL_P3_ANSI.sql')
]

csv_files_p3 = [
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'bestellung.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'kunde.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'lieferadresse.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'lieferdienst.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'Lieferung.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'position.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'produkt.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'produktkategorie.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'vereinspartner.csv'),
    os.path.join(folders_config['WEBSHOP_PERIODE_3'], 'wohnort.csv')
]

for sql_file in sql_files_p3:
    with open(sql_file, 'r') as file:
        sql_commands = file.read().split(';')
    execute_sql_commands(sql_commands, 'WILLIBALD_WEBSHOP_P3')

for csv_file in csv_files_p3:
    table_name = csv_to_table_mapping.get(os.path.basename(csv_file), os.path.splitext(os.path.basename(csv_file))[0])
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_WEBSHOP_P3')




# SQL-Skripte und CSV-Dateien für WILLIBALD_ROADSHOW_T1
sql_files_t1 = [
    os.path.join(folders_config['ROADSHOW_TAG_1'], '_Roadshow_DDL_1_ANSI.sql')
]

csv_files_t1 = [
    os.path.join(folders_config['ROADSHOW_TAG_1'], 'RS_Bestellung.csv')
]

for sql_file in sql_files_t1:
    with open(sql_file, 'r') as file:
        sql_commands = file.read().split(';')
    execute_sql_commands(sql_commands, 'WILLIBALD_ROADSHOW_T1')

for csv_file in csv_files_t1:
    table_name = csv_to_table_mapping.get(os.path.basename(csv_file), os.path.splitext(os.path.basename(csv_file))[0])
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_ROADSHOW_T1')




# SQL-Skripte und CSV-Dateien für WILLIBALD_ROADSHOW_T2
sql_files_t2 = [
    os.path.join(folders_config['ROADSHOW_TAG_2'], '_Roadshow_DDL_2_ANSI.sql')
]

csv_files_t2 = [
    os.path.join(folders_config['ROADSHOW_TAG_2'], 'RS_Bestellung.csv')
]

for sql_file in sql_files_t2:
    with open(sql_file, 'r') as file:
        sql_commands = file.read().split(';')
    execute_sql_commands(sql_commands, 'WILLIBALD_ROADSHOW_T2')

for csv_file in csv_files_t2:
    table_name = csv_to_table_mapping.get(os.path.basename(csv_file), os.path.splitext(os.path.basename(csv_file))[0])
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_ROADSHOW_T2')




# SQL-Skripte und CSV-Dateien für WILLIBALD_ROADSHOW_T3
sql_files_t3 = [
    os.path.join(folders_config['ROADSHOW_TAG_3'], '_Roadshow_DDL_3_ANSI.sql')
]

csv_files_t3 = [
    os.path.join(folders_config['ROADSHOW_TAG_3'], 'RS_Bestellung.csv')
]

for sql_file in sql_files_t3:
    with open(sql_file, 'r') as file:
        sql_commands = file.read().split(';')
    execute_sql_commands(sql_commands, 'WILLIBALD_ROADSHOW_T3')

for csv_file in csv_files_t3:
    table_name = csv_to_table_mapping.get(os.path.basename(csv_file), os.path.splitext(os.path.basename(csv_file))[0])
    load_csv_to_snowflake(csv_file, table_name, 'WILLIBALD_ROADSHOW_T3')

# Views im Schema WILLIBALD_WEBSHOP erstellen
tables_p1 = [
    'bestellung',
    'termintreue',
    'kunde',
    'lieferadresse',
    'lieferdienst',
    'Lieferung',
    'position',
    'produkt',
    'kategorie',
    'produkt_typ',
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
