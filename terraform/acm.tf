#Certificate creation
resource "aws_acm_certificate" "edu_manage_cert" {
  domain_name       = "edumanage.cloudyhub.online"
  validation_method = "DNS"

  subject_alternative_names = ["www.edumanage.cloudyhub.online"]

  tags = {
    Name = "EduManage ACM Certificate"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#DNS Validation for Route53
resource "aws_route53_record" "acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.edu_manage_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = data.aws_route53_zone.edu_manage_zone.id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

#Certificate
resource "aws_acm_certificate_validation" "edu_manage_validation" {
  certificate_arn         = aws_acm_certificate.edu_manage_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation : record.fqdn]
}