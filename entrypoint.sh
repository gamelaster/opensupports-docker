#!/bin/bash
set -e

if [[ -n "$TIMEZONE" ]]
then
  ln -snf /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime
  echo "$TIMEZONE" > /etc/timezone
  dpkg-reconfigure -f noninteractive tzdata
fi
echo "date.timezone=$(cat /etc/timezone)" > /usr/local/etc/php/conf.d/timezone.ini

if [ ! -d /config ]; then
	mkdir /config
fi

if [ ! -f /config/config.php ]; then
	touch /config/config.php
	chmod 777 /config/config.php
fi

rm /var/www/html/api/config.php
ln -s /config/config.php /var/www/html/api/config.php

exec "$@"
