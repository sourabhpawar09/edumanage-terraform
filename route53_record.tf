#ALB Alias Record for Root Domain
resource "aws_route53_record" "edu_alb_record" {
  zone_id = aws_route53_zone.edu_manage_zone.id
  name    = "edumanage.gt.tc"
  type    = "A"

  alias {
    name                   = aws_lb.application_lb.dns_name
    zone_id                = aws_lb.application_lb.zone_id
    evaluate_target_health = true
  }

}

#CName Records
resource "aws_route53_record" "edu_WWW_record" {
  zone_id = aws_route53_zone.edu_manage_zone.id
  name    = "WWW.edumanage.gt.tc"
  type    = "CNAME"
  ttl     = 300
  records = ["edumanage.gt.tc"]
}