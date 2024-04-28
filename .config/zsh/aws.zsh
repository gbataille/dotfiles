aws_get_account_id()
{
  aws sts get-caller-identity --output text --query 'Account'
}
aws_get_canonical_account_id()
{
  aws s3api list-buckets --query Owner.ID
}

awsdev()
{
  aws $@ --profile dev
}
