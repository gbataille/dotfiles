aws_get_account_id()
{
  ave $1 -- aws sts get-caller-identity --output text --query 'Account'
}
aws_get_canonical_account_id()
{
  ave $1 -- aws s3api list-buckets --query Owner.ID
}

awsdev()
{
  aws $@ --profile dev
}

# Init SSH keys
# init_ssh_keys.sh
# Setup local DNS
# setup_host_file.sh

avmfa() {
  ykman oath accounts code | grep aws-sdc | awk '{print $2}' | pbcopy
}
ave()
{
  aws-vault exec --prompt=ykman $@
}
avl()
{
  aws-vault login -d 1h --prompt=ykman $@
}
avpmr()
{
  aws-vault exec --prompt=ykman $@ -- python manage.py runserver 0.0.0.0:8000
}
avpms()
{
  aws-vault exec --prompt=ykman $@ -- python manage.py shell_plus
}
