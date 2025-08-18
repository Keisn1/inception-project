#!/usr/bin/env sh

# Wait for MariaDB to be ready
echo "Waiting for MariaDB..."
while ! nc -z mariadb 3306; do
    sleep 2
done

echo "MariaDB is ready!"

# Check if WordPress is already installed
if ! wp core is-installed 2>/dev/null; then
    echo "Installing WordPress..."

    # Install WordPress
    wp core install \
        --url="https://kfreyer.42.fr" \
        --title="Inception WordPress" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASS}" \
        --admin_email="${WP_ADMIN_EMAIL}" \

    # Create a regular user
    wp user create \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --role=editor \
        --user_pass="${WP_USER_PASS}" \
        --send-email=no

    echo "Debug: WP_ADMIN_EMAIL = '${WP_ADMIN_EMAIL}'"
    echo "Debug: WP_ADMIN_USER = '${WP_ADMIN_USER}'"
    echo "WordPress setup complete!"
else
    echo "WordPress is already installed"
fi
