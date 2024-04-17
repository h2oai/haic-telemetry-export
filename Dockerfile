FROM python:3.10-alpine

WORKDIR /workspace

COPY scripts/sql sql

COPY scripts/telemetry_data_export.py telemetry_data_export.py

RUN python -m pip install --no-cache-dir \
    pandas \
    psycopg2-binary \
    loguru \
    dsnparse

CMD [ "python", "telemetry_data_export.py" ]
