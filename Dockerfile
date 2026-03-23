from postgres:latest
COPY structure_db.sql /docker-entrypoint-initdb.d/
EXPOSE 5432