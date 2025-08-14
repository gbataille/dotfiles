# LightFrame shortcuts
export LF_DIR="/Users/gbataille/Documents/Prog/LightFrame/Shift"
export LF_DATA_DIR="/Users/gbataille/Documents/Data/Postgres/LightFrame_Dev"

alias dcu='pushd $GITROOT/back; docker compose up; popd'
alias dcud='pushd $GITROOT/back; docker compose up -d; popd'
alias dcd='pushd $GITROOT/back; docker compose down; popd'
alias dcl='pushd $GITROOT/back; docker compose logs; popd'
alias dcr='pushd $GITROOT/back; docker compose down && docker compose up -d; popd'

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
    -v $LF_DIR/back/core/config/create_postgresql_schema.sql:/docker-entrypoint-initdb.d/create_schema.sql  \
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
alias coverage='pushd $GITROOT/back; mvn test -P coverage; open core/target/site/jacoco/index.html; popd'

function first-ec2() {
    aws ec2 describe-instances --output json | \
    jq -r '.Reservations[].Instances[] | select(.State.Name == "running") | .InstanceId' |head -n1
}

function rds-connect-choice() {
  if [[ -z "$1" ]]; then
    echo "Usage: rds-connect <ec2-instance-id>"
    return 1
  fi
  local ec2_instance_id="$1"
  # Get a list of RDS instances.
  local instances=$(aws rds describe-db-instances --output json | jq -r '.DBInstances[] | "\(.DBInstanceIdentifier) (\(.DBInstanceStatus)) (\(.Endpoint.Address))"')
  if [[ -z "$instances" ]]; then
    echo "No RDS instances found."
    return 1
  fi
  # Selection (fzf or manual).  We still need to select the *RDS* instance.
  if command -v fzf >/dev/null; then
    local selected_instance=$(echo "$instances" | fzf --prompt="Select RDS instance: " --header="Instance Identifier (Status) (Endpoint)" --layout=reverse --border --height 40%  --preview 'aws rds describe-db-instances --db-instance-identifier {1} --output text' --preview-window=right:60%)
    if [[ -z "$selected_instance" ]]; then
      echo "No RDS instance selected."
      return 1
    fi
    local selected_identifier=$(echo "$selected_instance" | awk '{print $1}')
  else
    echo "Available RDS Instances:"
    echo "$instances" | while read -r line; do
      echo "- $line"
    done
    read -r -p "Enter the RDS Instance Identifier: " selected_identifier
  fi
    # Validate RDS selection
    if ! echo "$instances" | grep -q -F "$selected_identifier"; then
        echo "Invalid RDS instance identifier: $selected_identifier"
        return 1
    fi
  # Get endpoint of the *selected RDS instance*.
  local selected_endpoint=$(aws rds describe-db-instances --db-instance-identifier "$selected_identifier" --output json | jq -r '.DBInstances[0].Endpoint.Address')
  if [[ -z "$selected_endpoint" ]]; then
    echo "Could not retrieve endpoint for RDS instance: $selected_identifier"
    return 1
  fi
  # Start tunnel using the provided EC2 instance ID.
  nohup aws ec2-instance-connect open-tunnel --instance-id "$ec2_instance_id" --local-port 8888 >/dev/null &
  sleep 2
  # Establish SSH tunnel to the selected RDS instance.
  ssh -fNT -L 5432:"$selected_endpoint":5432 ec2-user@localhost -p 8888
  # Verify
  ps -ef | grep -i "ssh -fNT" | grep -v grep
}

function kill-tunnels() {
    kill -15 $(lsof -i -nP |grep 8888 |grep LISTEN |awk '{print $2}')
}
