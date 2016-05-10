#Docker App Auto Deployment Simple Weather App

FROM richarvey/nginx-php-fpm

# COPY app files to nginx web dir
RUN mkdir /usr/share/nginx/html/simple-weather
COPY . /usr/share/nginx/html/simple-weather/