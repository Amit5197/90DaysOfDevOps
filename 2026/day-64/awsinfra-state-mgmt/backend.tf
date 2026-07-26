terraform {
  backend "s3" {
    bucket         = "terraweek-state-amitkumar"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraweek-state-lock"
    encrypt        = true
  }
}
