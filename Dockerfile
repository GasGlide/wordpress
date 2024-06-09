# You can change this to a different version of Wordpress available at
# https://hub.docker.com/_/wordpress
#FROM wordpress:5.3.2-apache

#RUN apt-get update && apt-get install -y magic-wormhole

#RUN usermod -s /bin/bash www-data
#RUN chown www-data:www-data /var/www
#USER www-data:www-data

# Use the official PHP 8.1 Apache image
FROM php:8.1-apache

# Install required PHP extensions and packages
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip \
    nano \
    magic-wormhole \
    && docker-php-ext-install mysqli pdo pdo_mysql zip

# Download and install WordPress
RUN curl -O https://wordpress.org/latest.tar.gz \
    && tar -xzvf latest.tar.gz -C /var/www/html --strip-components=1 \
    && rm latest.tar.gz

# Set up permissions
RUN chown -R www-data:www-data /var/www/html/
USER www-data

# Expose port 80 and set the default command
EXPOSE 80
CMD ["apache2-foreground"]
