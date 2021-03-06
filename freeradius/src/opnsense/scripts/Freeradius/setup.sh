#!/bin/sh

RADIUS_FILES="/var/log/radius.log /var/log/radutmp /var/log/radwtmp /var/log/xv"
RADIUS_DIRS="/usr/local/etc/raddb /var/run/radiusd /var/log/radacct"
RADIUS_USER=freeradius
RADIUS_GROUP=freeradius

for DIR in ${RADIUS_DIRS}; do
	mkdir -p ${DIR}
	chmod -R 750 ${DIR}
	chown -R ${RADIUS_USER}:${RADIUS_GROUP} ${DIR}
done

for FILE in ${RADIUS_FILES}; do
	touch ${FILE}
	chmod 700 ${FILE}
done

php /usr/local/opnsense/scripts/Freeradius/generate_certs.php

chmod +x /usr/local/etc/raddb/queries.sh
/usr/local/etc/raddb/queries.sh >>/var/log/queries.log 2>&1