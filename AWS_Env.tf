resource "aws_vpc" "my_vpc" {
  cidr_block          = "10.0.0.0/16"
  enable_dns_support  = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet_a" {
  vpc_id           = aws_vpc.my_vpc.id
  cidr_block       = "10.0.0.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet_b" {
  vpc_id           = aws_vpc.my_vpc.id
  cidr_block       = "10.0.1.0/24"
  availability_zone = "us-east-1b"
}

resource "aws_security_group" "my_security_group" {
  name = "MySecurityGroup"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance_a" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_a.id
  security_groups = [aws_security_group.my_security_group.id]
}

resource "aws_instance" "ec2_instance_b" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_b.id
  security_groups = [aws_security_group.my_security_group.id]
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

resource "null_resource" "create_ami" {
  triggers = {
    instance_ids = "${aws_instance.ec2_instance_a.id}${aws_instance.ec2_instance_b.id}"
  }

  provisioner "local-exec" {
    command = <<EOT
      #!/bin/bash
      instance_ids=(${aws_instance.ec2_instance_a.id} ${aws_instance.ec2_instance_b.id})
      for instance_id in "\${instance_ids[@]}"; do
        aws ec2 create-image --instance-id "\$instance_id" --name "MyServer-Image-\$instance_id" --description "AMI for MyServer" --no-reboot
      done
    EOT
  }
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
    }
  }
}
