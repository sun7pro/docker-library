FROM php:7.3-cli

RUN pecl install xdebug pcov

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer


RUN apt-get update && apt-get install -y \
    unzip \
    --no-install-recommends \
    && rm -r /var/lib/apt/lists/*
