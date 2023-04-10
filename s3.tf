resource "aws_s3_bucket" "week21prj" {
  bucket = "week21prj"
  tags = {
    Name        = "s3 back bucket"
    Environment = "dev"
  }
}
resource "aws_s3_bucket_versioning" "week21prj" {
  bucket = aws_s3_bucket.week21prj.id

  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_public_access_block" "week21prj" {
  bucket = aws_s3_bucket.week21prj.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


