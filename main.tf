

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

resource "aws_autoscaling_group" "wk21asg" {
  name_prefix         = "wk21asg"
  max_size            = 5
  min_size            = 2
  desired_capacity    = 2
  vpc_zone_identifier = [var.subnet_id_1, var.subnet_id_2]
  launch_template {
    id = aws_launch_template.wk21-lt-1.id
  }
}


#create launch template
resource "aws_launch_template" "wk21-lt-1" {
  name          = "wk21-launchtemplate"
  instance_type = "t2.micro"
  image_id      = var.AMI
  key_name      = var.keyname

  user_data = filebase64("${path.root}/apache.sh")
}
