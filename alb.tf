resource "aws_lb" "r_innovation_alb" {
  name               = "${local.env_name}-${local.client}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_alb_rinnovation_sg.id]
  subnets            = module.vpc.public_subnets
}

resource "aws_security_group" "allow_alb_rinnovation_sg" {
  name        = "${local.env_name}-${local.client}-alb-sg"
  description = "Allow HTTP and HTTPS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "HTTPS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = local.common_tags
}

resource "aws_lb_target_group" "default_rinnovation" {
  name     = "${local.env_name}-${local.client}-default"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_lb_listener" "rinnovation_default_listener" {
  load_balancer_arn = aws_lb.r_innovation_alb.arn
  port              = "80"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    
    forward {
      target_group {
        arn = aws_lb_target_group.default_rinnovation.arn
      }
    }
    
  }
  
  # default_action {
  #   type = "redirect"

  #   redirect {
  #     port        = "443"
  #     protocol    = "HTTPS"
  #     status_code = "HTTP_301"
  #   }
    # }
}