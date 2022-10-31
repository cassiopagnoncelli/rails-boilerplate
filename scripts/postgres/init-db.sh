set -e

# https://hub.docker.com/_/postgres
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
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

CREATE DATABASE $POSTGRES_USER;

GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;
EOSQL
