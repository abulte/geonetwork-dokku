#!/bin/sh

# TODO: make volume?
export DATA_DIR=/catalog-data
export TZ=Europe/Paris

## Parse DATABASE_URL DSN into components

# Extract protocol (if present)
protocol=$(echo "$DATABASE_URL" | sed -n 's/^\(.*:\/\/\).*/\1/p')

# Remove protocol from the DSN
url=$(echo "$DATABASE_URL" | sed "s|$protocol||")

# Extract user and password (if present)
user=$(echo "$url" | sed -n 's/^\([^:@]*\):.*/\1/p')
pass=$(echo "$url" | sed -n 's/^[^:]*:\([^@]*\)@.*/\1/p')

# Remove user and password from the URL
hostport=$(echo "$url" | sed 's/^[^@]*@//')

# Extract host and port
host=$(echo "$hostport" | sed 's/:.*//')
port=$(echo "$hostport" | sed -n 's/^[^:]*:\([^/]*\).*/\1/p')

# Extract database name
db=$(echo "$hostport" | sed -n 's/^[^/]*\/\(.*\)/\1/p')

printf "Host: %s\n" "$host"
printf "Port: %s\n" "$port"
printf "Username: %s\n" "$user"
# printf "Password: %s\n" "$pass"
printf "Database: %s\n" "$db"

export POSTGRES_DB_HOST=$host
export POSTGRES_DB_PORT=$port
export POSTGRES_DB_NAME=$db
export POSTGRES_DB_USERNAME=$user
export POSTGRES_DB_PASSWORD=$pass

# Call the original entrypoint with CMD arguments
exec "$@"

