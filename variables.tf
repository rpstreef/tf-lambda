
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
# Variables: Lambda required
# -----------------------------------------------------------------------------

variable "lambda_function_name" {
  description = "Name of the Lambda function, this will also determine it's handler path"
}

variable "lambda_layer_arn" {
  description = "Lambda layer ARN that holds the dependencies for this Lambda function"
}

variable "lambda_role_arn" {
  description = "IAM Role ARN that defines all access rights to AWS services required by this Lambda function"
}

variable "lambda_environment_variables" {
  description = "Lambda environment variables"
  type        = map(string)
}

variable "reserved_concurrent_executions" {
  description = " (Optional) The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."
  type        = number
  default     = 10
}

variable "log_retention_in_days" {
  description = "How many days should logs be kept in CloudWatch"
  type        = number
  default     = 30
}

# -----------------------------------------------------------------------------
# Variables: Lambda optional
# -----------------------------------------------------------------------------

variable "lambda_timeout" {
  description = "Timeout in seconds"
  default     = 10
}

variable "lambda_memory_size" {
  description = "Allocated memory (and indirectly CPU power)"
  default     = 512
}

variable "lambda_runtime" {
  description = "Runtime of this Lambda function"
  default     = "nodejs12.x"
}

variable "tracing_config_mode" {
  description = "Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with 'sampled=1'. If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision"
  default     = "PassThrough"
}

# -----------------------------------------------------------------------------
# Variables: API Gateway integration
# -----------------------------------------------------------------------------
variable "create_api_gateway_integration" {
  description = "If we integrate with API Gateway, enable this. Default enabled"
  type        = bool
  default     = true
}

variable "api_gateway_rest_api_id" {
  description = "API Gateway REST API identifier, default null"
  type        = string
  default     = null
}

# -----------------------------------------------------------------------------
# Variables: SQS integration
# -----------------------------------------------------------------------------
variable "create_sqs_integration" {
  description = "If we integrate with SQS as event source, enable this. Default false"
  type        = bool
  default     = false
}

variable "sqs_arn" {
  description = "SQS ARN string"
  type        = string
  default     = null
}

variable "sqs_batch_size" {
  description = "The largest number of records that Lambda will retrieve from your event source at the time of invocation. Defaults to 100 for DynamoDB and Kinesis, 10 for SQS."
  type        = number
  default     = 10
}

# -----------------------------------------------------------------------------
# Variables: Cloudwatch Alarms errorRate
# -----------------------------------------------------------------------------

variable "create_errorRate_alarm" {
  description = "Creates the resource (true) or not (false)"
  type        = bool
  default     = true
}

variable "errorRate_threshold" {
  description = "The value against which the specified statistic is compared"
  default     = 0.01
}

variable "errorRate_evaluationPeriods" {
  description = "The number of periods over which data is compared to the specified threshold"
  default     = 5
}

# -----------------------------------------------------------------------------
# Variables: Cloudwatch Alarms throttleCount
# -----------------------------------------------------------------------------

variable "create_throttleCount_alarm" {
  description = "Creates the resource (true) or not (false)"
  type        = bool
  default     = true
}

variable "throttleCount_threshold" {
  description = "The value against which the specified statistic is compared"
  default     = 1
}

variable "throttleCount_evaluationPeriods" {
  description = "The number of periods over which data is compared to the specified threshold"
  default     = 1
}

# -----------------------------------------------------------------------------
# Variables: Cloudwatch Alarms iteratorAge
# -----------------------------------------------------------------------------

variable "create_iteratorAge_alarm" {
  description = "Creates the resource (true) or not (false)"
  type        = bool
  default     = true
}

variable "iteratorAge_threshold" {
  description = "The value against which the specified statistic is compared"
  default     = 60000
}

variable "iteratorAge_evaluationPeriods" {
  description = "The number of periods over which data is compared to the specified threshold"
  default     = 5
}

# -----------------------------------------------------------------------------
# Variables: Cloudwatch Alarms deadLetterQueue
# -----------------------------------------------------------------------------

variable "create_deadLetterQueue_alarm" {
  description = "Creates the resource (true) or not (false)"
  type        = bool
  default     = true
}

variable "deadLetterQueue_threshold" {
  description = "The value against which the specified statistic is compared"
  default     = 1
}

variable "deadLetterQueue_evaluationPeriods" {
  description = "The number of periods over which data is compared to the specified threshold"
  default     = 1
}

# -----------------------------------------------------------------------------
# Variables: SNS
# -----------------------------------------------------------------------------
variable "create_sns_topic_subscription" {
  description = "Subscribe this Lambda to an SNS topic, true or fale"
  type        = bool
  default     = false
}

variable "sns_topic_arn" {
  description = "SNS topic ARN"
  type        = string
  default     = null
}
