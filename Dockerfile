FROM alpine:3.16.0

LABEL org.opencontainers.image.authors "Richard Kojedzinszky <richard@kojedz.in>"
LABEL org.opencontainers.image.source https://github.com/euronetzrt/django

# Install python3 and frequent packages
RUN apk add --no-cache tzdata py3-pip py3-psycopg2 py3-grpcio py3-protobuf && \
    ln -sf python3 /usr/bin/python && ln -sf pip3 /usr/bin/pip && \
    pip install --no-cache -U \
    'django<3.3' \
    django-atomic-migrations \
    django-dbconn-retry \
    django-tastypie && \
    rm -rf /root/.cache
