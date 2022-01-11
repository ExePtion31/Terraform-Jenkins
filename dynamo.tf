resource "aws_dynamodb_table" "products_table" {
  name           = "${var.stack_id}-products-table"
  hash_key       = "ID_PRODUCT"
  range_key      = "NAME_PRODUCT"
  read_capacity  = 30
  write_capacity = 30
  tags           = local.common_tags

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

  local_secondary_index {
    name            = "price-index"
    range_key       = "PRICE_PRODUCT"
    projection_type = "ALL"
  }

  local_secondary_index {
    name            = "amount-index"
    range_key       = "AMOUNT_PRODUCT"
    projection_type = "ALL"
  }

  ttl {
    attribute_name = "TTL"
    enabled        = true
  }

  stream_enabled   = true
  stream_view_type = "NEW_IMAGE"
}
