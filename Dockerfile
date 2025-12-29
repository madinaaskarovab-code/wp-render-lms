FROM wordpress:6.5-php8.2-apache

RUN a2enmod rewrite headers expires

# Устанавливаем SQLite integration
RUN curl -L https://downloads.wordpress.org/plugin/sqlite-database-integration.zip -o /tmp/sqlite.zip \
 && unzip /tmp/sqlite.zip -d /var/www/html/wp-content/plugins \
 && rm /tmp/sqlite.zip

# Активируем SQLite
RUN cp /var/www/html/wp-content/plugins/sqlite-database-integration/db.php \
      /var/www/html/wp-content/db.php
