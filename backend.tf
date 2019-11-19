terraform {
  backend "s3" {
    profile        = "emp_jungle"
    bucket         = "todorov-infrastructure"
    dynamodb_table = "todorov-infrastructure"
    key            = "todorov-infrastructure/challenge/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
  }
}
