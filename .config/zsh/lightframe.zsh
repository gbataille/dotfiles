# LightFrame shortcuts
export LF_DIR="/Users/gbataille/Documents/Prog/LightFrame/Shift"
export LF_DATA_DIR="/Users/gbataille/Documents/Data/Postgres/LightFrame_Dev"

alias mcc='pushd $GITROOT/back; mvn clean install -DskipTests; popd'
alias mct='pushd $GITROOT/back; mvn clean test; popd'
alias mctv='pushd $GITROOT/back; mvn clean test -DredirectTestOutputToFile=false; popd'
alias mci='pushd $GITROOT/back; mvn clean install; popd'
alias nrb='pushd $GITROOT/front/shift; npm run build; popd'
alias nrd='pushd $GITROOT/front/shift; npm run dev; popd'
alias nrdp='pushd $GITROOT/front/shift; NODE_ENV=production npm run dev; popd'
alias nrt='pushd $GITROOT/front/shift; npm run test; popd'

pgup()
{
  docker run --rm -it -d -p 5433:5432 \
    --name pg_shift \
    -e POSTGRES_PASSWORD=db_password \
    -e POSTGRES_USER=db_user \
    -e POSTGRES_DB=shiftdb \
    -v $LF_DIR/back/springBoot/config/create_postgresql_schema.sql:/docker-entrypoint-initdb.d/create_schema.sql  \
    -v $LF_DATA_DIR:/var/lib/postgresql/data \
    postgres:16
}
pgdown()
{
  docker stop pg_shift 2>/dev/null
}
pgnew()
{
  pgdown
  rm -rf $LF_DATA_DIR
  mkdir -p $LF_DATA_DIR
  sleep 1
  pgup
}
pgrestart()
{
  pgdown
  pgup
}
alias coverage='pushd $GITROOT/back; mvn test -P coverage; open springBoot/target/site/jacoco/index.html; popd'
