#!/bin/sh
echo "Start migrate"
# autogenerete migrate
alembic -c ./migrations/alembic.ini revision --autogenerate
# make migrations
alembic -c ./migrations/alembic.ini  upgrade head
# autogenerete migrate
alembic revision --autogenerate
# make migrations
alembic upgrade head
