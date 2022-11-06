FROM composer:2.4.2 as vendor
WORKDIR /app
COPY composer.json composer.json
COPY composer.lock composer.lock
RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist \
    --quiet

FROM php:8.1.12-fpm
RUN apt update \
    && apt upgrade -y \    
    && apt install -y nginx
RUN docker-php-ext-install pdo_mysql bcmath > /dev/null
# configuring nginx
COPY nginx.conf /etc/nginx/nginx.conf
# create system user ("example_user" with uid 1000)
RUN useradd -G www-data,root -u 1000 -d /home/example_user example_user
RUN mkdir /home/example_user && \
    chown -R example_user:example_user /home/example_user
WORKDIR /var/www
COPY . /var/www/
COPY --from=vendor /app/vendor/ /var/www/vendor
# copy existing application directory permissions
COPY --chown=example_user:example_user ./ /var/www
EXPOSE 80
COPY docker-entry.sh /etc/entrypoint.sh
ENTRYPOINT ["sh", "-c", "php-fpm -D \ 
    && chgrp www-data -R /var/www/public/uploads \
    && chmod -R g+rwx /var/www/public/uploads \
    && nginx -g 'daemon off;'"]
