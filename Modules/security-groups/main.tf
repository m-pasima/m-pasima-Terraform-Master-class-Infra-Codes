# Security group for Application Load Balancer to allow HTTP AND HTTPS 
#=======================================================================

resource "aws_security_group" "alb_security_group" {
  name        = "${var.project_name}-alb-sg"
  description = "Allow HTTP/HTTPS inbound traffic"
  vpc_id      =   aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_allow_http" {
  security_group_id = aws_security_group.alb_security_group.id
  cidr_ipv4         = "0.0.0.0/0" # open to everywhwere on the internet
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

    tags = {
    Name = "${var.project_name}-alb-http-ingress"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_allow_https" {
  security_group_id = aws_security_group.alb_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443

  
  tags = {
    Name = "${var.project_name}-alb-https-ingress"
  }

}

resource "aws_vpc_security_group_egress_rule" "alb_allow_all_outbound" {
  security_group_id = aws_security_group.alb_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports

  tags = {
    Name = "${var.project_name}-alb-all-egress"
  }

}


#Allow HTTP from only from ALB(Not the internet)

resource "aws_security_group" "ecs_security_group" {
  name        = "${var.project_name}-ecs-sg"
  description = "Allow ALB ONLY inbound traffic for ecs containers"
  vpc_id      =  aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name}-ecs-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_allow_http_sg_from_alb" {
  security_group_id            = aws_security_group.ecs_security_group.id
  referenced_security_group_id =   aws_security_group.alb_security_group.id       
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

    tags = {
    Name = "${var.project_name}-ecs-http-from-alb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_allow_https_sg_from_alb" {
  security_group_id            = aws_security_group.ecs_security_group.id
  referenced_security_group_id =   aws_security_group.alb_security_group.id       
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443

    tags = {
    Name = "${var.project_name}-ecs-https-from-alb"
  }           

  
  

}

resource "aws_vpc_security_group_egress_rule" "ecs_allow_all_outbound" {
  security_group_id = aws_security_group.alb_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports

  tags = {
    Name = "${var.project_name}-ecs-all-egress"
  }

}

