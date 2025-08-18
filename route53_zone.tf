resource "aws_route53_zone" "edu_manage_zone" {
  name = "edumanage.gt.tc"

  tags = {
    Name = "EduManage-HostedZone"
  }

}