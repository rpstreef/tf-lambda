# -----------------------------------------------------------------------------
# Variables: General
# -----------------------------------------------------------------------------

variable "namespace" {
  description = "AWS resource namespace/prefix"
}

variable "region" {
  description = "AWS region"
}

variable "resource_tag_name" {
  description = "Resource tag name for cost tracking"
}

# -----------------------------------------------------------------------------
# Variables: SNS
# -----------------------------------------------------------------------------
variable "sns_topic_subscription" {
  description = "Subscribe this Lambda to an SNS topic, true or fale"
  type        = bool
  default     = false
}

variable "sns_topic_arn" {
  description = "SNS topic ARN"
  type        = string
  default     = null
}

variable "lambda_function_arn" {
  description = "Lambda function ARN that subscribes to this topic"
  type        = string
  default     = null
}
