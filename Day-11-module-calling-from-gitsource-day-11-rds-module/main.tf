
module "rds" {
  source = "github.com/garigevamshi291-cyber/Terraform-0730am/Day-11-rds-module"
   #vpc_cidr = "10.0.0.0/16"

subnets = {
  subnet1 = {
    cidr = "10.0.0.0/24"
    az   = "us-east-1a"
  }
  subnet2 = {
    cidr = "10.0.1.0/24"
    az   = "us-east-1b"
  }
}

db_identifier         = "rds-test"
db_name               = "mydb"
db_instance_class     = "db.t3.micro"
db_allocated_storage  = var.db_allocated_storage
db_username           = var.db_username


backup_window      = "02:00-03:00"
maintenance_window = "sun:04:00-sun:05:00"


}