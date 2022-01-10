FROM alpine:3.15
MAINTAINER Mayank Pundir <mayank.pundir@razorpay.com>
LABEL Description="Use certbot-dns-route53 plugin to issue TLS certs in a jiffy"

RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime
RUN echo "http://dl-3.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories

RUN apk update
RUN apk upgrade

RUN apk add --no-cache \
    bash \
    curl \
    linux-headers \
    openssl-dev \
    libffi-dev \
    musl-dev \
    groff \
    less \
    cargo \
    gcc \
    git

ENV PYTHONUNBUFFERED=1

RUN echo "**** install Python ****" && \
    apk add --no-cache python3 python3-dev && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

RUN pip install certbot \
    && cd /opt \
    && git clone https://github.com/certbot/certbot \
    && cd certbot/certbot-dns-route53 \
    && pip install .

ENTRYPOINT ["/bin/bash"]
