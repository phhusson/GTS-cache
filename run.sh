#!/bin/bash

set -e

mkdir -p /srv/squid3/certs/
if [ ! -f /srv/squid3/certs/docker.dev.crt ];then
	openssl req \
		-new \
		-newkey rsa:2048 \
		-sha256 \
		-days 3650 \
		-nodes -x509 -extensions v3_ca \
		-subj "/C=US/ST=California/L=San Francisco/O=ACME, Inc./CN=*.*.docker.dev/" \
		-keyout /srv/squid3/certs/private.pem \
		-out /srv/squid3/certs/private.pem
	openssl x509 -in /srv/squid3/certs/private.pem -outform DER -out /srv/squid3/certs/docker.dev.crt
fi

chown squid:squid -R /srv/squid3/

/usr/lib/squid/ssl_crtd -c -s /var/lib/ssl_db
squid -z -N -f /squid.cfg
squid -N -f /squid.cfg
