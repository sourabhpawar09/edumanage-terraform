#S3 LOGS 
resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "logs_bucket" {
  bucket = "edumanage-logs-${random_id.suffix.hex}"

  force_destroy = true

  tags = {
    Name        = "EduManage-logs"
    Environment = "dev"
  }
}

# S3 BUCKET POLICY
resource "aws_s3_bucket_policy" "logs_bucket_policy" {
  bucket = aws_s3_bucket.logs_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AWSALBLoggingPermissions"
        Effect = "Allow"
        Principal = {
          Service = "logdelivery.elasticloadbalancing.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.logs_bucket.arn}/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}
