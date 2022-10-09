#!/bin/bash

if [ ! -f "vendor/autoload.php" ]; then
    echo "oops, no vendor file found"
    echo "running artisan install..."
    composer install --no-progress --no-interaction
else
    echo "vendor/autoload.php exists."
    echo "skiping to next step..."
fi

if [ ! -f ".env" ]; then
    echo "Creating env file for env $APP_ENV"
    cp .env.example .env
else
    echo "env file exists."
fi

echo "running artisan command..."
php artisan migrate 
php artisan serve --port=$PORT --host=0.0.0.0 --env=.env

exec docker-php-entrypoint "$@"