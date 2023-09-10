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

resource "aws_security_group" "my_security_group" {
  name = "MySecurityGroup"
  vpc_id = aws_vpc.my_vpc.id

  # Inbound rules
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # כדאי להתאים את זה לצרכים שלך
  }

  # Outbound rules (allow all traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance_a" {
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.subnet_a.id
  security_groups = [aws_security_group.my_security_group.id]
  ami             = aws_image.my_custom_ami.id
}

resource "aws_instance" "ec2_instance_b" {
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.subnet_b.id
  security_groups = [aws_security_group.my_security_group.id]
  ami             = aws_image.my_custom_ami.id
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
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      content      = "OK"
    }
  }
}

# Create an EC2 instance to build the custom AMI
resource "aws_instance" "ami_builder" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI ID (us-east-1)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_a.id
  security_groups = [aws_security_group.my_security_group.id]

  # Additional configuration for your builder instance
  # ...
}

# Use a null_resource to trigger the creation of the AMI
resource "null_resource" "create_ami" {
  triggers = {
    instance_ids = [aws_instance.ami_builder.id]
  }

  # Local-exec provisioner can run a script to create the AMI
  provisioner "local-exec" {
    command = <<EOT
      #!/bin/bash
      instance_id="${aws_instance.ami_builder.id}"
      image_name="my-custom-ami"
      
      # Stop the instance
      aws ec2 stop-instances --instance-ids $instance_id
      
      # Create the AMI
      aws ec2 create-image --instance-id $instance_id --name $image_name --no-reboot
      
      # Wait for the AMI creation to complete
      aws ec2 wait image-available --image-ids $image_name
      
      # Clean up - terminate the builder instance
      aws ec2 terminate-instances --instance-ids $instance_id
    EOT
  }
}

# Use the newly created AMI in your EC2 instances
resource "aws_image" "my_custom_ami" {
  name        = "My Custom AMI"
  instance_id = aws_instance.ami_builder.id
}

# Wait for the AMI creation to complete before using it
data "aws_ami" "my_custom_ami" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["My Custom AMI"]
  }
}
