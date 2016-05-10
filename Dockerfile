#Docker App Auto Deployment Simple Weather App

FROM richarvey/nginx-php-fpm

# Copy app to /nginx web dir
COPY . /usr/share/nginx/html
