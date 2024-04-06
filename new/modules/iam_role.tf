

resource "aws_iam_policy" "bucket_policy" {
  name        = "my-bucket-policy"
  path        = "/"
  description = "Allow "

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "VisualEditor0"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ]
        Resource = ["${aws_s3_bucket.rentzone-app.arn}/*"]
          
      }
    ]
  })
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "bade_bucket_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}
 

resource "aws_iam_instance_profile" "bade_profile" {
  name = "bade-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "web_instances" {
  ami           = "ami-03ab7423a204da002"
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.some_profile.id
}


