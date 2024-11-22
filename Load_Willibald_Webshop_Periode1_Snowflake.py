import snowflake.connector
import os

#pip install snowflake-connector-python


# Snowflake-Verbindungsinformationen
account = 'your_account'
user = 'your_username'
password = 'your_password'
warehouse = 'your_warehouse'
database = 'your_database'
schema = 'WILLIBALD_SHOP_P1'

# Verbindung zu Snowflake herstellen
conn = snowflake.connector.connect(
    user=user,
    password=password,
    account=account,
    warehouse=warehouse,
    database=database,
    schema=schema
)

# SQL-Skripte ausführen
def execute_sql_file(file_path):
    with open(file_path, 'r') as file:
        sql_commands = file.read()
    cursor = conn.cursor()
    try:
        cursor.execute(sql_commands)
        print(f"{file_path} erfolgreich ausgeführt.")
    except Exception as e:
        print(f"Fehler beim Ausführen von {file_path}: {e}")
    finally:
        cursor.close()

# SQL-Skripte ausführen
sql_files = [
    '/willibald-data/Webshop/_Testdaten_DDL_1_ANSI.sql',
    '/willibald-data/Webshop/Dubletten_ANSI.sql'
]

for sql_file in sql_files:
    execute_sql_file(sql_file)

# Liste der CSV-Dateien
csv_files = [
    '/willibald-data/Webshop/Testdaten Periode 2/bestellung.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/href_termintreue.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/kunde.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/lieferadresse.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/lieferdienst.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/Lieferung.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/postition.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/produkt.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/produktkategorie.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/ref_produkt_typ.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/vereinspartner.csv',
    '/willibald-data/Webshop/Testdaten Periode 2/wohnort.csv'
]

# Funktion zum Laden einer CSV-Datei in Snowflake
def load_csv_to_snowflake(file_path, table_name):
    cursor = conn.cursor()
    try:
        # Erstelle eine temporäre Stage
        stage_name = f"{table_name}_stage"
        cursor.execute(f"CREATE OR REPLACE TEMPORARY STAGE {stage_name}")

        # Lade die CSV-Datei in die temporäre Stage
        cursor.execute(f"PUT file://{file_path} @{stage_name}")

        # Lade die Daten aus der Stage in die Tabelle
        cursor.execute(f"""
            COPY INTO {table_name}
            FROM @{stage_name}
            FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY='"')
        """)

        print(f"{file_path} erfolgreich in {table_name} geladen.")
    except Exception as e:
        print(f"Fehler beim Laden von {file_path} in {table_name}: {e}")
    finally:
        cursor.close()

# Lade jede CSV-Datei in die entsprechende Tabelle
for file_path in csv_files:
    table_name = os.path.splitext(os.path.basename(file_path))[0]
    load_csv_to_snowflake(file_path, table_name)

# Verbindung schließen
conn.close()
