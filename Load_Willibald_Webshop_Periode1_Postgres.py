import psycopg2
import os

#pip install psycopg2

# PostgreSQL-Verbindungsinformationen
host = 'your_host'
database = 'your_database'
user = 'your_username'
password = 'your_password'
schema = 'WILLIBALD_SHOP_P1'

#pip install psycopg2


# Verbindung zu PostgreSQL herstellen
conn = psycopg2.connect(
    host=host,
    database=database,
    user=user,
    password=password
)

# SQL-Skripte ausführen
def execute_sql_file(file_path):
    with open(file_path, 'r') as file:
        sql = file.read()
    cursor = conn.cursor()
    cursor.execute(f"SET search_path TO {schema}")
    cursor.execute(sql)
    conn.commit()
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
    '/willibald-data/Webshop/Testdaten Periode 1/bestellung.csv',
    '/willibald-data/Webshop/Testdaten Periode 1/href_termintreue.csv',
    '/willibald-data/Webshop/Testdaten Periode 1/kunde.csv',
    '/willibald-data/Webshop/Testdaten Periode 1/lieferadresse.csv',
    '/willibald-data/Webshop/Testdaten Periode 1/lieferdienst.csv',
    '/willibald-data/Webshop/Testdaten Periode 1/Lieferung.csv',
    '/willibald-data/Webshop/Testdaten Periode 1/postition.csv',
    '/willibald-data/Webshop/Testdaten Periode 1/produkt.csv',
    '/willibald-data/Webshop/Testdaten Periode 1/produktkategorie.csv',
    '/willibald-data/Webshop/Testdaten Periode 1/ref_produkt_typ.csv',
    '/willibald-data/Webshop/Testdaten Periode 1/vereinspartner.csv',
    '/willibald-data/Webshop/Testdaten Periode 1/wohnort.csv'
]

# Funktion zum Laden einer CSV-Datei in PostgreSQL
def load_csv_to_postgres(file_path, table_name):
    cursor = conn.cursor()
    try:
        with open(file_path, 'r') as file:
            next(file)  # Überspringe die Kopfzeile
            cursor.copy_expert(f"COPY {schema}.{table_name} FROM STDIN WITH CSV HEADER", file)
        conn.commit()
        print(f"{file_path} erfolgreich in {table_name} geladen.")
    except Exception as e:
        print(f"Fehler beim Laden von {file_path} in {table_name}: {e}")
    finally:
        cursor.close()

# Lade jede CSV-Datei in die entsprechende Tabelle
for file_path in csv_files:
    table_name = os.path.splitext(os.path.basename(file_path))[0]
    load_csv_to_postgres(file_path, table_name)

# Verbindung schließen
conn.close()
