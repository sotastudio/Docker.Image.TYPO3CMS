#!/bin/bash

cd /var/www/html && \
    ./typo3conf/ext/typo3_console/typo3cms install:setup --force \
        --database-user-name "typo3" --database-user-password "typo3pwd" \
        --database-host-name "t38dev-db" --database-name "typo3" --database-port "3306" --database-socket "" \
        --admin-user-name "admin" --admin-password "password" \
        --site-name "TYPO3 Project" --site-setup-type "no" \
        --no-interaction 1 --use-existing-database 1 && \
    ./typo3conf/ext/typo3_console/typo3cms cache:flush && \
    ./typo3/cli_dispatch.phpsh extbase extension:install scheduler && \
    ./typo3/cli_dispatch.phpsh extbase extension:install typo3_console && \
    ./typo3/cli_dispatch.phpsh extbase extension:install bootstrap_package && \
    ./typo3/cli_dispatch.phpsh extbase extension:install introduction && \
    ./typo3/cli_dispatch.phpsh extbase extension:install extension_builder && \
    chown -R www-data. .