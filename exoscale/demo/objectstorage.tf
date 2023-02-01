resource "aws_s3_bucket" "incoming" {
  bucket = "c2corg-demov6-incoming"
}

resource "aws_s3_bucket" "active" {
  bucket = "c2corg-demov6-active"
}

resource "aws_s3_bucket" "tracking" {
  bucket = "c2corg-demov6-tracking"
}
