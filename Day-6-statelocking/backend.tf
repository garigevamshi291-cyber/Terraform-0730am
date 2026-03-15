terraform {
  backend "s3" {
    bucket = "my-terraform-vamshi-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
