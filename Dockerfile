FROM alpine:latest

MAINTAINER phh@phh.me

RUN apk update && \
	apk add curl squid bash openssl && \
	rm -Rf /var/cache/apk/*

COPY run.sh /
COPY squid.cfg /

ENTRYPOINT [ "bash", "/run.sh" ]
