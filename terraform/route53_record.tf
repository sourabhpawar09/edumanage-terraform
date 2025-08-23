# Fetch existing Route 53 Hosted Zone
data "aws_route53_zone" "edu_manage_zone" {
  name         = "cloudyhub.online"
  private_zone = false
}


#ALB Alias Record for Root Domain
resource "aws_route53_record" "edu_alb_record" {
  zone_id = data.aws_route53_zone.edu_manage_zone.id
  name    = "edumanage.cloudyhub.online"
  type    = "A"

  alias {
    name                   = aws_lb.application_lb.dns_name
    zone_id                = aws_lb.application_lb.zone_id
    evaluate_target_health = true
  }

}

#CName Records
resource "aws_route53_record" "edu_WWW_record" {
  zone_id = data.aws_route53_zone.edu_manage_zone.id
  name    = "www.edumanage.cloudyhub.online"
  type    = "CNAME"
  ttl     = 300
  records = ["edumanage.cloudyhub.online"]
}