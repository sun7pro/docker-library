FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libicu-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    git vim unzip cron \
    --no-install-recommends \
    && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) intl

RUN docker-php-ext-install -j$(nproc) opcache bcmath pdo_mysql soap xsl zip sockets

# Install Xdebug (but don't enable)
RUN pecl install -o xdebug

# Install nvm, node, grunt
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
    && . ~/.bashrc \
    && nvm install 12 \
    && npm i -g grunt-cli

# Install Composer (version 2), support magento 2.3.7 and >= 2.4.2. See: https://devdocs.magento.com/guides/v2.4/install-gde/system-requirements.html
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Install mhsendmail
RUN curl -Lo mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 \
    && mv mhsendmail /usr/local/bin/ \
    && chmod +x /usr/local/bin/mhsendmail

# Set magento file permissions
RUN useradd -m -s /bin/bash magento \
    && usermod -a -G www-data magento

RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

ADD ./php-custom.ini $PHP_INI_DIR/conf.d/
# Crontab for user magento
ADD ./magento.cron /var/spool/cron/crontabs/magento
RUN chmod 600 /var/spool/cron/crontabs/magento && chgrp crontab /var/spool/cron/crontabs/magento
# Custom entrypoint to start cron service
ADD custom-entrypoint.sh /usr/local/bin/

# Add virmrc
ADD .vimrc /root/.vimrc
ADD .vimrc /home/magento/.vimrc
# Add some alias
ADD .bash_aliases /usr/local/share/.bash_aliases
# Improve shell prompt: [+] root @ /var/www/html/magento
RUN printf '\nfunction nonzero_return() { RETVAL=$? ; [ $RETVAL -ne 0 ] && echo "[exit code: $RETVAL]" ; }\n \
    PS1="\n\[\e[37m\][+]\[\e[m\]\[\e[m\] \[\e[32m\]\u\[\e[m\] \[\e[34m\]@\[\e[m\] \[\e[36m\]\w \[\e[31m\]\`nonzero_return\`\[\e[m\]\n\\\$ > "\n \
    . /usr/local/share/.bash_aliases\n' | tee --append /etc/bash.bashrc /home/magento/.bashrc

ENTRYPOINT [ "/usr/local/bin/custom-entrypoint.sh" ]

CMD ["php-fpm"]

EXPOSE 9000
