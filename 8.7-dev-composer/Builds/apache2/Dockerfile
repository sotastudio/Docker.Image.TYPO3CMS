FROM php:7.2-apache
LABEL maintainer="Andy Hausmann <ah@sota-studio.de>"

ENV APACHE_DOCUMENT_ROOT /var/www/html/web
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV OAUTH_TOKEN access-token

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Install TYPO3
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
# Configure PHP
        libxml2-dev libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        zlib1g-dev \
        zip git \
# Install required 3rd party tools
        graphicsmagick && \
# Configure extensions
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) mysqli soap gd zip opcache intl && \
    echo 'always_populate_raw_post_data = -1\nmax_execution_time = 240\nmax_input_vars = 1500\nupload_max_filesize = 32M\npost_max_size = 32M\ndisplay_errors = 1' > /usr/local/etc/php/conf.d/typo3.ini && \
# Configure Apache as needed
    a2enmod rewrite && \
    apt-get clean && \
    apt-get -y purge \
        libxml2-dev libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/* /usr/src/*

COPY ./Resources/ /var/www/html/resources

RUN cd /var/www && \
    mkdir -p .composer && \
    chown -R www-data. .composer

RUN cd /var/www/html && \
    mkdir -p web && \
    chown -R www-data. .

RUN cd /var/www/html && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer && \
    php -r "unlink('composer-setup.php');"
    # composer config --global --auth github-oauth.github.com ${OAUTH_TOKEN}

# Configure volumes
VOLUME /var/www/html/web/fileadmin
VOLUME /var/www/html/web/typo3conf
VOLUME /var/www/html/web/typo3temp
VOLUME /var/www/html/web/uploads
