FROM alpine:3.7
MAINTAINER Michael Schaller

# base
RUN apk add --no-cache bash openssl openssl-dev curl python3 python3-dev musl-dev libffi-dev make gcc && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache && \
    apk add --no-cache --virtual .build-dependencies git

# dehydrated & hetzner hook
RUN git clone https://github.com/lukas2511/dehydrated.git /opt/dehydrated \
    && ln -s /opt/dehydrated/dehydrated /usr/local/bin \
    && git clone https://github.com/rembik/dehydrated-hetzner-hook.git /opt/dehydrated-hetzner-hook \
    && pip3 install -r /opt/dehydrated-hetzner-hook/requirements.txt \
    && sed -i -e 's@#!/usr/bin/env python@#!/usr/bin/env python3@' /opt/dehydrated-hetzner-hook/hook.py

RUN apk del .build-dependencies

ENTRYPOINT ["/opt/dehydrated/dehydrated"]
