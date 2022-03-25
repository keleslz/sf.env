FROM php:8.1-apache

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git libzip-dev zip

# Configure modules to install
RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql && \
    docker-php-ext-configure zip --with-zip && \
    pecl install xdebug

# PHP modules installation
RUN docker-php-ext-install pdo_mysql zip
RUN docker-php-ext-enable xdebug
RUN a2enmod rewrite

# Copy composer from composer image
COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# set document root
ENV APACHE_DOCUMENT_ROOT /var/www/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
