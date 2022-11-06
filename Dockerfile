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

FROM php:8.1-fpm-alpine as phpserver
RUN apk update \
    && apk upgrade \    
    && apk add nginx
RUN docker-php-ext-install pdo_mysql bcmath > /dev/null
COPY nginx.conf /etc/nginx/nginx.conf
WORKDIR /var/www
COPY . /var/www/
COPY --from=vendor /app/vendor/ /var/www/vendor
EXPOSE 80
COPY docker-entry.sh /etc/entrypoint.sh
ENTRYPOINT ["sh", "/etc/entrypoint.sh"]
