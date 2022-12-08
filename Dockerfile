FROM php:7.4-apache

ENV URL https://github.com/opensupports/opensupports/releases/download/v4.11.0/opensupports_v4.11.0.zip

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
	chmod -R 777 /var/www/html/api/vendor/ezyang/htmlpurifier/library/HTMLPurifier/DefinitionCache/; \
    patch /var/www/html/index.php < /var/www/html/fix-https-reverse-proxy.diff;


COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
