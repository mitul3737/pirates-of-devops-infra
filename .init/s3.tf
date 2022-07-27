resource "aws_s3_bucket" "terraform_state" {
  bucket = "piratesofdevops-iac-state"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
}