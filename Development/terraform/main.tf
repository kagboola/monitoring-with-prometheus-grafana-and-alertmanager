
//create security group to allow port 22, 80 , 443
//create a network interface with an ip in the subnet that was created
//create ubuntu server and install apache2 and enable

//create security group to allow port 22, 80,
resource "aws_vpc" "monitoring-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "monitoring"
  }
}

resource "aws_security_group" "monitoring_web" {
  name        = "monitoring_web_traffic"
  
  ingress {
    description = "HTTP"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 9093
    to_port     = 9093
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 9300
    to_port     = 9300
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 9115
    to_port     = 9115
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    description = "HTTP"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
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
    Name = "monitoring_web"
  }
}


resource "aws_instance" "monitoring" {
  ami           = var.MONITORING_SERVER_TO_DEPLOY
  instance_type = "t2.micro"
  key_name      = "mac-ireland"
  vpc_security_group_ids = [aws_security_group.monitoring_web.id]
  tags = {
    Name        = "monitoring_server"
  }
}

resource "aws_instance" "webserver" {
  ami           = var.WEBSERVER_TO_DEPLOY
  instance_type = "t2.micro"
  key_name      = "mac-ireland"
  vpc_security_group_ids = [aws_security_group.monitoring_web.id]
  tags = {
    Name        = "webserver-node"
  }
}

