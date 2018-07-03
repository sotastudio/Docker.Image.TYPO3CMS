#!/bin/bash

cd /var/www/html && \
    # remove CMS files
    rm -R typo3_src-* && \
    rm typo3_src index.php typo3 .htaccess && \
    # remove essential folders
    rm -R typo3temp/* typo3conf/* fileadmin/* uploads/*
    rm FIRST_INSTALL

