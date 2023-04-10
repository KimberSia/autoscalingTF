terraform {
  backend "s3" {
    bucket = "week21prj"
    key    = "state-files/terraform.tfstate"
    region = "us-east-1"
  }
}