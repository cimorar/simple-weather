#Docker App Auto Deployment Simple Weather App

FROM richarvey/nginx-php-fpm

# ADD app files to nginx web dir
ADD * /usr/share/nginx/html/
