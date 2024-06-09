# You can change this to a different version of Wordpress available at
# https://hub.docker.com/_/wordpress
#FROM wordpress:5.3.2-apache

#RUN apt-get update && apt-get install -y magic-wormhole

#RUN usermod -s /bin/bash www-data
#RUN chown www-data:www-data /var/www
#USER www-data:www-data

# Use the WordPress image with PHP 8.1
FROM wordpress:5.3.2-php8.1-apache

# Update the package list and install magic-wormhole
RUN apt-get update && apt-get install -y magic-wormhole

# Change the default shell for the www-data user to /bin/bash
RUN usermod -s /bin/bash www-data

# Change the ownership of the /var/www directory to www-data
RUN chown www-data:www-data /var/www

# Switch to the www-data user
USER www-data
