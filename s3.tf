# Create storage bucket
resource "aws_s3_bucket" "trail_bucket" {
  bucket = var.s3_bucket_name
  tags   = var.tags
}

# Make the bucket private
resource "aws_s3_bucket_acl" "trail_bucket_acl" {
  bucket = aws_s3_bucket.trail_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "trail_bucket_public_access" {
  bucket = aws_s3_bucket.trail_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "trail_bucket_encryption" {
  bucket = aws_s3_bucket.trail_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}