#!bin/sh

CONFIG_FILE="/var/www/wp-config.php"

if [ ! -f "$CONFIG_FILE" ]; then
    cat << EOF > "$CONFIG_FILE"
<?php
define( 'DB_NAME', '${DB_NAME}' );
define( 'DB_USER', '${DB_USER}' );
define( 'DB_PASSWORD', '${DB_PASS}' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

// Filesystem method for updates and installation
define('FS_METHOD', 'direct');

\$table_prefix = 'wp_';

// Debug mode
define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

// Redis configuration
define('WP_REDIS_CLIENT', 'predis');
define('WP_REDIS_SCHEME', 'tcp');
define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );
define( 'WP_REDIS_DATABASE', 0 );
define('WP_CACHE', true);
define('WP_REDIS_PASSWORD', '${WP_REDIS_PASSWORD}');

require_once ABSPATH . 'wp-settings.php';
EOF
fi
