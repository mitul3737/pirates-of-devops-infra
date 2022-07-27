terraform {
  backend "s3" {
    bucket         = "piratesofdevops-iac-state"
    key            = "keyfiles"
    region         = "ap-southeast-1"
    dynamodb_table = "piratesofdevops-iac-state"
  }
}

provider "aws" {
  alias  = "piratesofdevops"
  region = "ap-southeast-1"
}
