FROM python:3.12-alpine

ARG ARA_VERSION

ENV ARA_BASE_DIR=/opt/ara

RUN mkdir "$ARA_BASE_DIR" \
    && apk add --no-cache-dir --virtual build-deps gcc musl-dev \
    && pip install --no-cache-dir "ara[server]==$ARA_VERSION" gunicorn \
    && apk del build-deps

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["gunicorn", "--workers=4", "--access-logfile", "-", "--bind", "0.0.0.0:8000", "ara.server.wsgi"]

VOLUME ["/opt/ara"]

EXPOSE 8000
