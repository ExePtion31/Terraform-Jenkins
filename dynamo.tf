resource "aws_dynamodb_table" "products_table" {
  name         = "${var.stack_id}-products-table"
  hash_key     = "ID_PRODUCT"
  range_key    = "NAME_PRODUCT"
  tags         = local.common_tags

  attribute {
    name = "ID_PRODUCT"
    type = "S"
  }

  attribute {
    name = "NAME_PRODUCT"
    type = "S"
  }

  attribute {
    name = "PRICE_PRODUCT"
    type = "S"
  }

  attribute {
    name = "AMOUNT_PRODUCT"
    type = "N"
  }

  stream_enabled   = true
  stream_view_type = "NEW_IMAGE"
}
