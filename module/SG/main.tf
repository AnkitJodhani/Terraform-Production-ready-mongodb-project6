#--------------------------------------------------------------------------------- Control-machine-sg-------------------------------------------------------------------

resource "aws_security_group" "control-machine" {
  name        = "control-machine"
  description = "control-machine security group"
  vpc_id      = var.VPC_ID

  # ingress {
  #   description = "http access"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "control-machine-sg"
  }
}

#--------------------------------------------------------------------------------- ALB-sg-------------------------------------------------------------------

# create security group for the application load balancer
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "enable http/https access on port 80/443"
  vpc_id      = var.VPC_ID

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB-SG"
  }
}

#--------------------------------------------------------------------------------- Nginx-EC2-sg-------------------------------------------------------------------

# create security group for the application load balancer
resource "aws_security_group" "nginx_sg" {
  name        = "nginx-ec2-sg"
  description = "enable http from ALB-sg on port 80"
  vpc_id      = var.VPC_ID

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    description = "allow control-machine"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.control-machine.id]
  }
  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Nginx-EC2-sg"
  }
  depends_on = [aws_security_group.alb_sg]
}

#--------------------------------------------------------------------------------- NLB-sg-------------------------------------------------------------------

# create security group for the Network load balancer
resource "aws_security_group" "nlb_sg" {
  name        = "nlb-sg"
  description = "enable http/https access on port 26000"
  vpc_id      = var.VPC_ID

  ingress {
    description = "https access"
    from_port   = 26000
    to_port     = 26000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "NLB-SG"
  }
}


#--------------------------------------------------------------------------------- Mongodb-cluster-ip -------------------------------------------------------------------

# create security group for the mongodb cluster
resource "aws_security_group" "mongodb_cluster_sg" {
  name        = "mongodb-cluster-sg"
  description = "enable tcp from nlb-sg on port 26000"
  vpc_id      = var.VPC_ID

  ingress {
    description = " access"
    from_port   = 26000
    to_port     = 26000
    protocol    = "tcp"
    security_groups = [aws_security_group.nlb_sg.id]
  }

  ingress {
    description = "allow control-machine"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.control-machine.id]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Mongodb-cluster"
  }
  depends_on = [aws_security_group.nlb_sg]
}


resource "aws_security_group_rule" "internal_traffic" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.mongodb_cluster_sg.id
  source_security_group_id = aws_security_group.mongodb_cluster_sg.id

}

