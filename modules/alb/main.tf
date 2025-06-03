resource "aws_lb" "application" {
  name               = "application-alb"
  internal           = false
  load_balancer_type = "application"
  #security_groups    = [aws_security_group.alb.id]
  subnets = values(var.subnet_ids)
}



