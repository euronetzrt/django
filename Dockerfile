FROM alpine:3.21.3

LABEL org.opencontainers.image.authors "Richard Kojedzinszky <richard@kojedz.in>"
LABEL org.opencontainers.image.source https://github.com/euronetzrt/django

# Install python3 and prepare virtualenv
RUN apk add --no-cache tzdata py3-pip py3-virtualenv && \
    virtualenv --system-site-packages /usr/local/py3-virtualenv && \
    apk del --no-cache py3-virtualenv

ENV \
    PATH=/usr/local/py3-virtualenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    PYTHONPATH=/usr/local/py3-virtualenv/lib/python3.12/site-packages

# Install frequent packages
RUN apk add --no-cache \
    py3-tz py3-asgiref py3-sqlparse py3-greenlet py3-mimeparse py3-dateutil \
    py3-psycopg2 py3-grpcio py3-protobuf py3-paho-mqtt py3-sqlalchemy && \
    pip install --no-cache -U \
    'django<5' \
    django-atomic-migrations \
    django-dbconn-retry \
    'django-db-connection-pool >= 1.0.7' \
    django-tastypie \
    https://github.com/rkojedzinszky/django-tastypie-openapi/archive/master.zip && \
    rm -rf /root/.cache

# Verify installation and environment settings
RUN /usr/bin/python -c 'import django'
