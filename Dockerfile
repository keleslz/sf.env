FROM php:8.0-apache

# Intall PHP extensions
RUN apt-get update && apt-get upgrade -y

# Install necessary lib to load packages from composer
RUN apt-get install -y git libzip-dev zip unzip wget ruby ruby-dev locales procps mariadb-client


# Enable .htacess support
RUN a2enmod rewrite

# Copy composer from composer image
COPY --from=composer /usr/bin/composer /usr/bin/composer
