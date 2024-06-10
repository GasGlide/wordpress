# Use the official PHP 8.1 Apache image
FROM php:8.1-apache

# Install system dependencies for GD and other extensions
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    zip \
    unzip \
    nano \
    magic-wormhole

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd mysqli pdo pdo_mysql zip

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
