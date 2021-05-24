#Laravel PHP-fpm alpine 8.0
FROM php:8.0-fpm-alpine

RUN apk --update add \
        wget \
        curl \
        build-base \
        composer \
        nodejs-current \
        nodejs-current-npm \
        libmcrypt-dev \
        libxml2-dev \
        pcre-dev \
        zlib-dev \
        autoconf \
        oniguruma-dev \
        openssl \
        openssl-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        jpeg-dev \
        libpng-dev \
        imagemagick-dev \
        imagemagick \
        postgresql-dev \
        libzip-dev \
        gettext-dev \
        libxslt-dev \
        libgcrypt-dev 

RUN pecl channel-update pecl.php.net \
    && pecl install mcrypt redis-5.3.4 \
    && pecl channel-update https://pecl.php.net/channel.xml

RUN docker-php-ext-install \
        mysqli \
        mbstring \
        pdo \
        pdo_mysql \
        tokenizer \
        xml \
        pcntl \
        bcmath \
        pdo_pgsql \
        zip \
        intl \
        gettext \
        soap \
        sockets \
        xsl \
    && docker-php-ext-configure gd --with-freetype=/usr/lib/ --with-jpeg=/usr/lib/ \
    && docker-php-ext-install gd \
    && docker-php-ext-enable redis

RUN rm -rf /tmp/pear \
    && rm /var/cache/apk/*

WORKDIR /var/www/html