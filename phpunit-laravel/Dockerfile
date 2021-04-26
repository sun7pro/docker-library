FROM php:7.4-apache

RUN a2enmod rewrite
ADD ./000-default.conf /etc/apache2/sites-available/000-default.conf

# Install unzip for composer
RUN apt-get update && apt-get install -y --no-install-recommends \
    vim \
    unzip \
    && rm -r /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

RUN docker-php-ext-install -j$(nproc) pdo_mysql

# Install Xdebug, pcov for generating code coverage
RUN pecl install xdebug pcov

RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
ADD ./php-custom.ini $PHP_INI_DIR/conf.d/

WORKDIR /var/www/html
EXPOSE 80
CMD ["apache2-foreground"]
