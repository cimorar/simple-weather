#Docker App Auto Deployment Simple Weather App

FROM ubuntu:14.04.4
MAINTAINER Tonia Thompson <writing@toniathompson.com>

# Surpress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Update base image
# Add sources for latest nginx
# Install software requirements
RUN apt-get update && \
apt-get install -y software-properties-common && \
nginx=stable && \
add-apt-repository ppa:nginx/$nginx && \
apt-get update && \
apt-get upgrade -y && \
BUILD_PACKAGES="supervisor nginx php5-fpm php5-curl" && \
apt-get -y install $BUILD_PACKAGES && \
apt-get remove --purge -y software-properties-common && \
apt-get autoremove -y && \
apt-get clean && \
apt-get autoclean && \
echo -n > /var/lib/apt/extended_states && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /usr/share/man/?? && \
rm -rf /usr/share/man/??_*

# Install Supervisor to run php-fpm and nginx side by side.
RUN /usr/bin/easy_install supervisor
RUN /usr/bin/easy_install supervisor-stdout
ADD ./supervisord.conf /etc/supervisord.conf

# tweak php-fpm & nginx config
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini && \
  sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf && \
	sed -i -e "s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf && \
  sed -i -e "s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Setup Volume
VOLUME ["/usr/share/nginx/html"]

EXPOSE 80
EXPOSE 443

# Spin up our Supervisor setup by default.
CMD ["/usr/local/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]