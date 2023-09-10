resource "aws_vpc" "my_vpc" {
  cidr_block          = "10.0.0.0/16"
  enable_dns_support  = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet_a" {
  vpc_id           = aws_vpc.my_vpc.id
  cidr_block       = "10.0.0.0/24"
  availability_zone = "us-east-1a"  # שנה את האזור כרצונך
}

resource "aws_subnet" "subnet_b" {
  vpc_id           = aws_vpc.my_vpc.id
  cidr_block       = "10.0.1.0/24"
  availability_zone = "us-east-1b"  # שנה את האזור כרצונך
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_main_route_table_association" "subnet_a_association" {
  subnet_id = aws_subnet.subnet_a.id
}

resource "aws_instance" "ec2_instance_a" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI ID (us-east-1)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_a.id
}

resource "aws_instance" "ec2_instance_b" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI ID (us-east-1)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_b.id
}

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

resource "aws_lb" "my_load_balancer" {
  name               = "MyLoadBalancer"
  subnets            = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  security_groups    = [aws_security_group.my_security_group.id]
  load_balancer_type = "application"

  enable_deletion_protection = false
  enable_http2               = true
  idle_timeout               = 60

  tags = {
    Name = "MyLoadBalancer"
  }
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group_arn = aws_lb_target_group.my_target_group.arn
    }
  }
}
