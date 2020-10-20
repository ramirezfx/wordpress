FROM ubuntu:latest
ARG sitename=test.test
ARG WPDB=speedypreneur
ARG WPUSER=speedypreneur
ARG WPPWD=53C8d8btGeDN

COPY ./keyboard /etc/default/keyboard
COPY resources/createdatabase.sql /tmp
COPY resources/example.conf /tmp
COPY resources/firstrun.sh /tmp

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y locales locales-all && \
    apt-get install -y tzdata && \
    apt-get install -y keyboard-configuration && \
    localedef -i de_AT -c -f UTF-8 -A /usr/share/locale/locale.alias de_AT.UTF-8 && \
    ln -fs /usr/share/zoneinfo/Europe/Vienna /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    dpkg-reconfigure --frontend noninteractive keyboard-configuration
#    rm -rf /var/lib/apt/lists/*

RUN apt-get install -y -q apt-utils software-properties-common
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y nginx mariadb-server mariadb-client certbot python3-certbot-nginx php7.4-fpm php7.4-common php7.4-mbstring php7.4-xmlrpc php7.4-gd php7.4-xml php7.4-mysql php7.4-cli php7.4-zip php7.4-curl wget
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php/7.4/fpm/php.ini
RUN cd /tmp && wget https://wordpress.org/latest.tar.gz
RUN cd /tmp && tar xzvf latest.tar.gz
RUN mv /tmp/wordpress /tmp/$sitename
RUN mv /tmp/$sitename /var/www/html
RUN chown -R www-data:www-data /var/www/html/$sitename
RUN chmod -R 755 /var/www/html/$sitename
RUN cd /tmp && mv example.conf $sitename.conf
RUN mv /tmp/$sitename.conf /etc/nginx/sites-enabled
RUN rm /etc/nginx/sites-enabled/default
RUN cd /etc/nginx/sites-enabled && sed -i "s/site/$sitename/g" $sitename.conf
RUN cd /etc/php/7.4/fpm && sed -i "s/memory_limit = 128M/memory_limit = 256M/g" php.ini
RUN cd /etc/php/7.4/fpm && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 256M/g" php.ini
RUN cd /etc/php/7.4/fpm && sed -i "s/max_execution_time = 30/max_execution_time = 360/g" php.ini
RUN echo "date.timezone = America/Chicago" >> /etc/php/7.4/fpm/php.ini
RUN cd /etc/php/7.4/fpm && sed -i "s/post_max_size = 8M/post_max_size = 256M/g" php.ini
RUN cd /etc/nginx && sed -i "s/# server_names_hash_bucket_size 64;/server_names_hash_bucket_size 64;/g" nginx.conf
RUN cd /tmp && sed -i "s/wpdb/$WPDB/g" createdatabase.sql
RUN cd /tmp && sed -i "s/wpuser/$WPUSER/g" createdatabase.sql
RUN cd /tmp && sed -i "s/wppwd/$WPPWD/g" createdatabase.sql

# ENV QT_GRAPHICSSYSTEM="native"
ENV LC_ALL de_AT.UTF-8
ENV LANG de_AT.UTF-8
ENV LANGUAGE de_AT.UTF-8
COPY entrypoint.sh /
RUN chmod +x entrypoint.sh
CMD service php7.4-fpm start && service mysql start && nginx
