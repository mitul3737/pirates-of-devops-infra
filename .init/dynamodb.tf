resource "aws_dynamodb_table" "terraform-state-lock" {
  name           = "piratesofdevops-iac-state"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
