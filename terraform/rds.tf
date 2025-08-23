#RDS Instance
resource "aws_db_instance" "edu_rds" {
  identifier             = "edu-rds"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  username               = "admin"
  password               = "EduManage123!"
  db_name                = "edudb"
  port                   = "3306"
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.edu_rds_subnet.name
  multi_az               = false
  publicly_accessible    = false
  storage_encrypted      = true
  skip_final_snapshot    = true

  tags = {
    Name = "EduManage-RDS"
  }
}