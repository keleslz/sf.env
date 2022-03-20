FROM php:8.0-apache

ENV NODE_VERSION=16.13.0

# Intall PHP extensions
RUN apt-get update && apt-get upgrade -y

# Install necessary lib to load packages from composer
RUN apt-get install -y git libzip-dev zip unzip wget ruby ruby-dev locales procps mariadb-client

# Enable .htacess support
RUN a2enmod rewrite

# Copy composer from composer image
COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"