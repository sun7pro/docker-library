FROM php:7.3-cli

RUN pecl install xdebug pcov

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer
