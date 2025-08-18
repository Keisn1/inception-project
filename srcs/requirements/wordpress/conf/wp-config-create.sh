#!bin/sh
#
if [ ! -f "/var/www/wp-config.php" ]; then
    cat <<EOF >/var/www/wp-config.php
<?php
define( 'DB_NAME', '${DB_NAME}' ); # PHP function creating constant
define( 'DB_USER', '${DB_USER}' );
define( 'DB_PASSWORD', '${DB_PASS}' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' ); # Empty = use database default
define('FS_METHOD','direct');
\$table_prefix = 'wp_';         # wordpress expects this specific variable name
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
define( 'ABSPATH', __DIR__ . '/' );}
require_once ABSPATH . 'wp-settings.php';
EOF
fi
