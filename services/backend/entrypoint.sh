#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $DB_HOST $DB_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

python manage.py migrate --no-input
python manage.py collectstatic --no-input


gunicorn example:app -w 4 -k uvicorn.workers.UvicornWorker
gunicorn settings.wsgi:application --reload --bind 0.0.0.0:8000 --workers 4
