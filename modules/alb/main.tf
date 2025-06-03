resource "aws_lb" "devlake" {
  name               = var.name 
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets = values(var.subnet_ids)
}

/*resource "aws_lb" "devlake_lb" {
  name                       = var.name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.security_group_id]
  subnets                    = var.subnet_ids
  drop_invalid_header_fields = true

  tags = var.tags
}*/


resource "aws_lb_target_group" "a" {
  name     = "tg-a"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = 80
    protocol = "HTTP"
    matcher = "200"
  }
}

/*resource "aws_lb_target_group" "devlake_tg" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    protocol            = var.health_check_protocol
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }

  tags = var.tags
}*/

resource "aws_lb_listener" "devlake" {
  load_balancer_arn = aws_lb.devlake.arn
  port              = "80"
  protocol            = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.a.arn
  }
}

/*resource "aws_lb_listener" "devlake_listener" {
  load_balancer_arn = aws_lb.devlake_lb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.devlake_tg.arn
  }
}*/

resource "aws_security_group" "alb" {
  name_prefix = "alb-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_lb_target_group_attachment" "A" {
  target_group_arn = var.target_group_a_arn
  target_id        = aws_instance.instance_A.id
  port             = 80
}