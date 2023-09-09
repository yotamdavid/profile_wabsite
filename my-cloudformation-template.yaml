# קובץ מסוים ל Terraform, לצורך יצירת VPC, Subnets, EC2 Instances, Security Groups, ו-ELB ב-AWS

# הגדרת VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

# הגדרת Internet Gateway
resource "aws_internet_gateway" "my_internet_gateway" {}

# קישור ה-Internet Gateway ל-VPC
resource "aws_vpc_attachment" "my_vpc_attachment" {
  vpc_id = aws_vpc.my_vpc.id
  internet_gateway_id = aws_internet_gateway.my_internet_gateway.id
}

# הגדרת Security Group
resource "aws_security_group" "my_security_group" {
  name = "Security Group for My Application"
  vpc_id = aws_vpc.my_vpc.id

  # Inbound rules
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust this as needed for your application
  }

  # Outbound rules (allow all traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# הגדרת Subnets
resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"  # Change the availability zone as needed
}

resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"  # Change the availability zone as needed
}

# הגדרת Route Table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id
}

# הגדרת SubnetRouteTableAssociation
resource "aws_subnet_route_table_association" "subnet_a_association" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_subnet_route_table_association" "subnet_b_association" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.my_route_table.id
}

# הגדרת EC2 Instances
resource "aws_instance" "ec2_instance_a" {
  ami           = "your-ami-id"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_a.id
  security_groups = [aws_security_group.my_security_group.name]
}

resource "aws_instance" "ec2_instance_b" {
  ami           = "your-ami-id"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_b.id
  security_groups = [aws_security_group.my_security_group.name]
}

# הגדרת Target Group
resource "aws_lb_target_group" "my_target_group" {
  name     = "MyTargetGroup"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

  health_check {
    protocol = "HTTP"
    port     = 5000
    path     = "/"
  }
}

# הגדרת Load Balancer
resource "aws_lb" "my_load_balancer" {
  name               = "MyLoadBalancer"
  subnets            = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  security_groups    = [aws_security_group.my_security_group.id]
  load_balancer_type = "application"
  enable_deletion_protection = false

  enable_http2               = true
  enable_deletion_protection = false
  idle_timeout               = 60

  enable_deletion_protection = false
  enable_http2               = true
  enable_deletion_protection = false

  tags = {
    Name = "MyLoadBalancer"
  }
}

# הגדרת Listener
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      content      = "OK"
    }
  }
}

# פלטפורמה: AWS
#   Stack Name: MyStackName
#   Date: 2023-09-09
