FROM php:7.2-cli-stretch

LABEL maintainer="Merlin Diavova <merlindiavova@pm.me>"

RUN apt-get update \
    && apt-get install -y git zip unzip \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && apt-get -y autoremove \
    && apt-get clean \
    && pecl install xdebug-2.6.0 \
    && docker-php-ext-enable xdebug \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo '#!/bin/bash\n./vendor/bin/phpunit "$@"' > /usr/bin/phpunit \
    && chmod +x /usr/bin/phpunit \
    && echo '#!/bin/bash\n./vendor/bin/phpcs -p -s "$@"' > /usr/bin/phpcs \
    && chmod +x /usr/bin/phpcs \
    && echo '#!/bin/bash\n./vendor/bin/covers-validator "$@"' > /usr/bin/covers \
    && chmod +x /usr/bin/covers \
    && echo '#!/bin/bash\n./vendor/bin/phpstan "$@"' > /usr/bin/phpstan \
    && chmod +x /usr/bin/phpstan \
    && echo '#!/bin/bash\n./vendor/bin/phpstan analyse --level=1 --no-progress src/ tests/ "$@"' > /usr/bin/stan \
    && chmod +x /usr/bin/stan \
    && echo '#!/bin/bash\nphpcs && stan' > /usr/bin/cs \
    && chmod +x /usr/bin/cs \
    && echo '#!/bin/bash\ncovers && phpunit' > /usr/bin/tests \
    && chmod +x /usr/bin/tests \
    && echo '#!/bin/bash\ntests && cs' > /usr/bin/ci \
    && chmod +x /usr/bin/ci