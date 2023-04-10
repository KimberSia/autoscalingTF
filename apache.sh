#!/bin/bash
sudo yum update -y
sudo yum install -y 
sudo yum install -y httpd
sudo yum start httpd
sudo yum enable httpd
