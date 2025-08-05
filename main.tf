resource "aws_s3_bucket" "tf_proj_state" {
  bucket        = "terraform-project-state-bucket"
  force_destroy = true #force_destroy = true is commonly used in non prod to destroy incase the bucket not empty
  tags = {
    Name        = "TerraformState"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "tf_proj_state_versioning" {

  bucket = aws_s3_bucket.tf_proj_state.id
  versioning_configuration {
    status = "Enabled"
  }


}




resource "aws_dynamodb_table" "tf_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "TerraformLocks"
    Environment = "Dev"
  }
}

