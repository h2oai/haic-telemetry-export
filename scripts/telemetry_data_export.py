import os
from time import sleep

import pandas as pd
import psycopg2
from loguru import logger

TELEMETRY_QUERY_TIMEOUT_MS = 2700000  # 45min in milliseconds


def run_sql_and_export(sql_file, output_file, conn):
    cur = conn.cursor()

    with open(sql_file, "r") as f:
        sql_script = f.read()

    logger.info(f"Executing {sql_file}")
    cur.execute(sql_script)

    logger.info(f"Exporting to {output_file} ...")
    query_result = pd.DataFrame(cur.fetchall(), columns=[desc[0] for desc in cur.description])
    query_result.to_csv(output_file, index=False)
    logger.info(f"Exported to {output_file}")

    cur.close()


def main():
    # To get the current status of the execution
    with open("TELEMETRY_EXPORT_STATUS", "w", encoding="utf=8") as f:
        f.write("0")

    os.mkdir("./data")
    sql_scripts = [
        "ai_unit_hourly",
        "aiem",
        "app_events",
        "hourly_max_ai_units",
        "instance_events",
        "hourly_consumption_details",
        "hourly_max_ai_units_cat",
        "user_login_data",
    ]

    logger.info("Connecting to database ...")
    conn = psycopg2.connect(
        dsn=os.getenv("DB_DSN"),
        options=f"-c statement_timeout={TELEMETRY_QUERY_TIMEOUT_MS}",
    )
    logger.info("Connected successfully")

    for script in sql_scripts:
        run_sql_and_export(sql_file=f"./sql/{script}.sql", output_file=f"./data/{script}.csv", conn=conn)

    conn.close()

    # Downloading can be started from now on
    with open("TELEMETRY_EXPORT_STATUS", "w", encoding="utf=8") as f:
        f.write("1")

    # Avoid pod deletion. Pod will be deleted by the shell script automatically.
    sleep(60 * 60 * 48)


if __name__ == "__main__":
    main()
