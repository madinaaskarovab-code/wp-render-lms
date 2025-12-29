FROM wordpress:6.5-php8.2-apache
RUN a2enmod rewrite headers expires
