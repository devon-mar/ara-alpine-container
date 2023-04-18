FROM python:3.11-alpine

ENV ARA_BASE_DIR=/opt/ara

RUN mkdir "$ARA_BASE_DIR" && pip install --no-cache-dir "ara[server]==$ARA_VESRION" gunicorn

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["gunicorn", "--workers=4", "--access-logfile", "-", "--bind", "0.0.0.0:8000", "ara.server.wsgi"]

VOLUME ["/opt/ara"]

EXPOSE 8000
