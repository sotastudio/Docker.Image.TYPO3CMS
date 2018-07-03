#!/bin/bash

cd /var/www/html && \
    chown -R www-data. . && \
    composer create-project typo3/cms-base-distribution new-typo3-project 8.7 && \
    cp -R new-typo3-project/* ./ && \
    rm -R new-typo3-project/ && \
    touch FIRST_INSTALL

cd /var/www && \
    mkdir -p .composer/ && \
    find ./typo3conf/ext/ -type f -print0 | xargs -0 chmod 755 && \
    find ./typo3conf/ext/ -type d -print0 | xargs -0 chmod 755

cd /var/www/html && \
    composer config repositories.repo-name vcs https://github.com/FriendsOfTYPO3/extension_builder.git && \
    composer require friendsoftypo3/extension-builder && \
    composer require typo3/cms-introduction:3.0.1 && \
    composer require helhum/typo3-console
