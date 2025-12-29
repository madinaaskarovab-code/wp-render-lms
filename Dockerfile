FROM wordpress:6.5-php8.2-apache

# Устанавливаем unzip
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

# Включаем нужные модули Apache
RUN a2enmod rewrite headers expires

# Устанавливаем SQLite integration
RUN curl -L https://downloads.wordpress.org/plugin/sqlite-database-integration.zip -o /tmp/sqlite.zip \
 && unzip /tmp/sqlite.zip -d /var/www/html/wp-content/plugins \
 && rm /tmp/sqlite.zip

# Активируем SQLite
# Активируем SQLite (в разных версиях файла может быть db.php или db.copy)
RUN if [ -f /var/www/html/wp-content/plugins/sqlite-database-integration/db.php ]; then \
      cp /var/www/html/wp-content/plugins/sqlite-database-integration/db.php /var/www/html/wp-content/db.php; \
    elif [ -f /var/www/html/wp-content/plugins/sqlite-database-integration/db.copy ]; then \
      cp /var/www/html/wp-content/plugins/sqlite-database-integration/db.copy /var/www/html/wp-content/db.php; \
    else \
      echo "SQLite plugin file not found" && ls -la /var/www/html/wp-content/plugins/sqlite-database-integration && exit 1; \
    fi
