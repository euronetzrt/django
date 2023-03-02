FROM alpine:3.17.2

LABEL org.opencontainers.image.authors "Richard Kojedzinszky <richard@kojedz.in>"
LABEL org.opencontainers.image.source https://github.com/euronetzrt/django

# Install python3 and frequent packages
RUN apk add --no-cache tzdata py3-pip \
    py3-tz py3-asgiref py3-sqlparse py3-greenlet py3-mimeparse py3-dateutil \
    py3-psycopg2 py3-grpcio py3-protobuf py3-paho-mqtt py3-sqlalchemy && \
    ln -sf python3 /usr/bin/python && ln -sf pip3 /usr/bin/pip && \
    pip install --no-cache -U \
    'django<3.3' \
    django-atomic-migrations \
    django-dbconn-retry \
    'django-db-connection-pool[postgresql] >= 1.0.7' \
    django-tastypie \
    https://github.com/rkojedzinszky/django-tastypie-openapi/archive/master.zip && \
    rm -rf /root/.cache
