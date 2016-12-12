FROM tsari/jessie-php-fpm
MAINTAINER Tibor Sári <tiborsari@gmx.de>

# update, install and clean up to minimize the image size
RUN \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y \
        php7.0-xdebug \
    && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# use our own xdebug configuration
COPY 20-xdebug.ini /etc/php/7.0/mods-available/xdebug.ini
RUN sed -i -e '1izend_extension=\'`find / -name "xdebug.so"` /etc/php/7.0/mods-available/xdebug.ini
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini