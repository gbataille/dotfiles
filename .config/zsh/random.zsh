generate_random_alpha()
{
  if [ -z "$1" ]; then; echo "Please pass a length as parameter"; return; fi
  LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c $1 | pbcopy
}

generate_random()
{
  if [ -z "$1" ]; then; echo "Please pass a length as parameter"; return; fi
  LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c $1 | pbcopy
}
