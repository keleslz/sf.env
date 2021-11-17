FROM php:8.0-apache

# Enable .htacess support
RUN a2enmod rewrite
