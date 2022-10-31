set -e

# https://hub.docker.com/_/postgres
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$STERN_PG_URL" <<-EOSQL
DO
   \$do\$
   BEGIN
      IF NOT EXISTS (
         SELECT FROM pg_catalog.pg_roles  -- SELECT list can be empty for this
         WHERE  rolname = '$POSTGRES_USER') THEN

         CREATE ROLE $POSTGRES_USER LOGIN PASSWORD '$POSTGRES_PASSWORD';
      END IF;
   END
\$do\$;

CREATE DATABASE stern_development;

GRANT ALL PRIVILEGES ON DATABASE stern_development TO $POSTGRES_USER;
EOSQL
