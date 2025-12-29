FROM wordpress:6.5-php8.2-apache

# unzip нужен для установки плагина
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

# Включаем модули Apache
RUN a2enmod rewrite headers expires

# Ставим SQLite Database Integration
RUN curl -L https://downloads.wordpress.org/plugin/sqlite-database-integration.zip -o /tmp/sqlite.zip \
 && unzip /tmp/sqlite.zip -d /var/www/html/wp-content/plugins \
 && rm /tmp/sqlite.zip

# Подключаем drop-in db.php (в разных версиях есть db.php или db.copy)
RUN if [ -f /var/www/html/wp-content/plugins/sqlite-database-integration/db.php ]; then \
      cp /var/www/html/wp-content/plugins/sqlite-database-integration/db.php /var/www/html/wp-content/db.php; \
    elif [ -f /var/www/html/wp-content/plugins/sqlite-database-integration/db.copy ]; then \
      cp /var/www/html/wp-content/plugins/sqlite-database-integration/db.copy /var/www/html/wp-content/db.php; \
    else \
      echo "SQLite plugin file not found" && ls -la /var/www/html/wp-content/plugins/sqlite-database-integration && exit 1; \
    fi

# ВАЖНО: создаём wp-config.php, чтобы WordPress НЕ просил MySQL-данные
RUN cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php \
 && sed -i "s/database_name_here/sqlite/g" /var/www/html/wp-config.php \
 && sed -i "s/username_here//g" /var/www/html/wp-config.php \
 && sed -i "s/password_here//g" /var/www/html/wp-config.php \
 && sed -i "s/localhost//g" /var/www/html/wp-config.php \
 && sed -i "1i<?php\\ndefine('WP_USE_EXT_MYSQL', false);\\n" /var/www/html/wp-config.php
