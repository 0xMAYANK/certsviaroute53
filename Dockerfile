FROM alpine:3.11.3
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
    python3-dev \
    libffi-dev \
    musl-dev \
    groff \
    less \
    gcc \
    git

RUN pip3 install --upgrade pip setuptools \
    && pip install certbot \
    && cd /opt \
    && git clone https://github.com/certbot/certbot \
    && cd certbot/certbot-dns-route53 \
    && pip install .

ENTRYPOINT ["/bin/bash"]
