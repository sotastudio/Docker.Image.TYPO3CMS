#!/bin/bash

cd /var/www/html && \
    # download CMS
    wget -O - https://get.typo3.org/8.7 | tar -xzf - && \
    ln -s typo3_src-* typo3_src && \
    ln -s typo3_src/index.php && \
    ln -s typo3_src/typo3 && \
    ln -s typo3_src/_.htaccess .htaccess && \
    # setup essential folders
    mkdir -p typo3temp && \
    mkdir -p typo3conf && \
    mkdir -p fileadmin && \
    mkdir -p uploads && \
    # prepare for first install
    touch FIRST_INSTALL

cd /var/www/html && \
    mkdir -p typo3conf/ext && \
    # copy pre-downloaded extensions to ext folder
    cp -R ./resources/Extensions/* /var/www/html/typo3conf/ext/ && \
    # fix rights
    chown -R www-data. . && \
    find ./typo3conf/ext/ -type f -print0 | xargs -0 chmod 755 && \
    find ./typo3conf/ext/ -type d -print0 | xargs -0 chmod 755

cd /var/www/html && \
    ./typo3conf/ext/typo3_console/typo3cms install:setup --force \
        --database-user-name "root" --database-user-password "root" \
        --database-host-name "db" --database-name "typo3" --database-port "3306" --database-socket "" \
        --admin-user-name "admin" --admin-password "password" \
        --site-name "TYPO3 Project" --site-setup-type "no" --extension:setup\
        --no-interaction --use-existing-database && \
    ./typo3conf/ext/typo3_console/typo3cms cache:flushcomplete && \
    ./typo3/cli_dispatch.phpsh extbase extension:install scheduler && \
    ./typo3/cli_dispatch.phpsh extbase extension:install typo3_console && \
    ./typo3/cli_dispatch.phpsh extbase extension:install bootstrap_package && \
    ./typo3/cli_dispatch.phpsh extbase extension:install introduction && \
    ./typo3/cli_dispatch.phpsh extbase extension:install extension_builder && \
    ./typo3conf/ext/typo3_console/typo3cms cache:flushcomplete && \
    chown -R www-data. .