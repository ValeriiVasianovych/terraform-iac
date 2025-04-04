

# resource "aws_lb" "web" {
#   name               = "WebServer-Highly-Available-LB"
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.web.id]
#   subnets            = ["${aws_default_subnet.default-az1.id}", "${aws_default_subnet.default-az2.id}"]
# } 

# resource "aws_lb_target_group" "web" {
#   name                 = "WebServer-Highly-Available-TG"
#   port                 = 80
#   protocol             = "HTTP"
#   vpc_id               = aws_default_vpc.default.id
#   deregistration_delay = 10
# }

# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.web.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.web.arn
#   }
# }

# output "web_lb_url_name" {
#   value = aws_lb.web.dns_name
# }