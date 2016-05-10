#Docker App Auto Deployment Simple Weather App

FROM richarvey/nginx-php-fpm

# COPY app files to nginx web dir
RUN mkdir /www
COPY index.php /usr/share/nginx/html
COPY src/* /usr/share/nginx/html