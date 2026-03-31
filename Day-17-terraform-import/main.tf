resource "aws_instance" "name" {
    ami = "ami-0c3389a4fa5bddaad"
    instance_type = "t3.micro"
    tags = {
    Name ="test"
    }
}


resource "aws_s3_bucket" "name" {
    bucket = "vamshis-terraform-bucketertyu"
  
}
resource "aws_s3_bucket_versioning" "name" {
    bucket = aws_s3_bucket.name.bucket
  versioning_configuration {
    status = "Enabled"
  }
}