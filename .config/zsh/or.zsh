# OrDynamics shortcuts
export OR_DIR="/Users/gbataille/Documents/Prog/OrDynamics/Shift"

pgup()
{
  docker run -it --rm -d -p 5433:5432 \
    --name pg_shift \
    -e POSTGRES_PASSWORD=db_password \
    -e POSTGRES_USER=db_user \
    -e POSTGRES_DB=shiftdb \
    -v $OR_DIR/back/springBoot/config/create_postgresql_schema.sql:/docker-entrypoint-initdb.d/create_schema.sql  \
    postgres:16
}
pgdown()
{
  docker stop pg_shift 2>/dev/null
}
pgrestart()
{
  pgdown
  pgup
}
