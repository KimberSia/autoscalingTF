#create a security group that allows to traffic to ssh/httpd/http
resource "aws_security_group" "wk21-secgrp" {
  name_prefix = "wk21-secgrp"
  vpc_id      = var.vpc_name


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "week21_security_group"
  }
}
#create launch template
resource "aws_launch_template" "wk21-launchtemplate" {
  name                                 = "wk21-launchtemplate"
  instance_type                        = "t2.micro"
  image_id                             = var.AMI
  key_name                             = var.keyname
  vpc_security_group_ids               = [aws_security_group.wk21-secgrp.id]
  user_data                            = filebase64("${path.module}/apache.sh")
  instance_initiated_shutdown_behavior = "terminate"

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true

  }
}
#create auto scaling group 

resource "aws_autoscaling_group" "week21_asg" {
  availability_zones        = ["us-east-1a"]
  desired_capacity          = 2
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  vpc_security_group_ids               = [aws_security_group.wk21-secgrp.id]
  

  launch_template {
    id      = aws_launch_template.wk21-launchtemplate.id
    version = "$Latest"
  }
}


  