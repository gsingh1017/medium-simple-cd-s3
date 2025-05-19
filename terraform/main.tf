#  Provider
provider "aws" {
  region = "ca-central-1" # change region
}

#  S3 Bucket
resource "aws_s3_bucket" "static_site" {
  bucket = "gs-medium-example-bucket" # make bucket name unique
}

#  S3 Bucket Policy
resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid: "PublicReadGetObject",
        Effect = "Allow",
        Principal = "*",
        Action = "s3:GetObject",
        Resource = "arn:aws:s3:::${aws_s3_bucket.static_site.id}/*"
      }
    ]
  })
}

# S3 Bucket Website Configuration
resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.static_site.id
  index_document {
    suffix = "index.html"
  }
}