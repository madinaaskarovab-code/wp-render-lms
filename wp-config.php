<?php
// SQLite database configuration
define('DB_NAME', 'sqlite');
define('DB_USER', '');
define('DB_PASSWORD', '');
define('DB_HOST', '');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

// Absolute path to the WordPress directory.
if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

// Use SQLite
define('WP_USE_EXT_MYSQL', false);

// Sets up WordPress vars and included files.
require_once ABSPATH . 'wp-settings.php';
