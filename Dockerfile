FROM php:apache

ENV URL https://github.com/opensupports/opensupports/releases/download/v4.9.0/opensupports_v4.9.0.zip

RUN set -ex; \
	apt-get update; \
	apt-get install -y unzip; \
	docker-php-ext-install pdo_mysql; \
	docker-php-ext-install mysqli; \
	curl -fsSL -o opensupports.zip $URL; \
	unzip opensupports.zip -d /var/www/html; \
	rm -r opensupports.zip; \
	a2enmod rewrite; \
	chmod 777 /var/www/html/api/config.php /var/www/html/api/files; \
	mv /var/www/html/index.php /var/www/html/append_index.php; \
	echo "<?php if(getenv(\"HOST\", false) !== false) \$_SERVER['HTTP_HOST'] = getenv(\"HOST\", false); ?>" >> /var/www/html/prepend_index.php; \
	cat /var/www/html/prepend_index.php >> /var/www/html/index.php; \
	rm /var/www/html/prepend_index.php; \
	cat /var/www/html/append_index.php >> /var/www/html/index.php; \
	rm /var/www/html/append_index.php; \
	chmod -R 777 /var/www/html/api/vendor/ezyang/htmlpurifier/library/HTMLPurifier/DefinitionCache/;

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]