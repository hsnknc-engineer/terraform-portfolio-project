provider "aws" {
  region = "eu-central-1"   # Europe (Frankfurt)
}

# S3 Bucket
resource "aws_s3_bucket" "nextjs_bucket" {
  bucket = "nextjs-portfolio-bucket-hasan"
}


# Ownership COntrol
resource "aws_s3_bucket_ownership_comtrols" "nextjs_bucket_ownership_controls" {
  bucket = aws_s3_bucket.nextjs_bucket.id

  rule {
    object_ownership = "BucketOwnerPreffered"
  }
}

# Block public Access
resource "aws_s3_bucket_public_acces_block" "nextjs_bucket_public_access_controls" {
  bucket = aws_s3_bucket.nextjs_bucket.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}


# Bucket ACL
resource "aws_s3_bucket_acl" "nextjs_bucket_acl" {
  depends_on = [ 
    aws_s3_bucket_ownership_comtrols.nextjs_bucket_ownership_controls,
    aws_aws_s3_bucket_public_acces_block.nextjs_bucket_public_access_controls
   ]
   bucket = aws_s3_bucket.nextjs_bucket.id
   acl = "public-read"
}














