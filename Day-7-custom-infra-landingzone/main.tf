resource "aws_vpc" "test" {  #creation of vpc, internet getway, route table, security group
    cidr_block = "10.0.0.0/16"
    tags = {
    Name = "test-vpc"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "nat-eip"
  }
  
}

resource "aws_nat_gateway" "name" {
 allocation_id = aws_eip.nat.id
 subnet_id = aws_subnet.public.id
  tags = {
    Name = "test-nat-gatway"
  }
  
}
#public subnet
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.test.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "test-subnet"
    }
}

#private subnet
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.test.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "test-subnet-2"
    }
} 

resource "aws_internet_gateway" "test" {
    vpc_id = aws_vpc.test.id
    tags = {
      Name = "test-internet-gateway"
    }
  
}
resource "aws_route_table" "test" {
    vpc_id = aws_vpc.test.id
     route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test.id
  }
}

 resource "aws_route_table_association" "test" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.test.id
  
}

resource "aws_security_group" "test" {
    name = "test-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id = aws_vpc.test.id

  #inbound rule to allow ssh traffic
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# outbound rule to allow all traffic
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
}
  

resource "aws_instance" "test" {
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.test.id]
    tags = {
      Name = "test_instance"
    }
  
}



