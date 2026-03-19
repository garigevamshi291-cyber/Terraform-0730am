module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type = "t3.micro"
  subnet_id     = "subnet-0ae3298ffa26542a1"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}