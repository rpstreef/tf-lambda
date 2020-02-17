
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

variable "distribution_file_name" {
  description = "Name of the ZIP file this Lambda function code will be bundled in to"
}

variable "lambda_filename" {
  description = "Name of the ZIP file this Lambda function code will be bundled in to"
}

variable "lambda_layer_arn" {
  description = "Lambda layer ARN that holds the dependencies for this Lambda function"
}

variable "lambda_role_arn" {
  description = "IAM Role ARN that defines all access rights to AWS services required by this Lambda function"
}

variable "dist_path" {
  description = "The directory path name to the distribution (zip) directory"
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
  default     = "nodejs10.x"
}

variable "tracing_config_mode" {
  description = "Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with 'sampled=1'. If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision"
  default     = "PassThrough"
}

# -----------------------------------------------------------------------------
# Variables: API Gateway integration
# -----------------------------------------------------------------------------
variable "api_gateway_permission" {
  description = "If we integrate with API Gateway, enable this"
  type        = number
  default     = 1
}

variable "api_gateway_rest_api_id" {
  description = "API Gateway REST API identifier, default null"
  type        = string
  default     = null
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
