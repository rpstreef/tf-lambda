# -----------------------------------------------------------------------------
# Locals
# -----------------------------------------------------------------------------
locals {
  resource_name_prefix = "${var.namespace}-${var.resource_tag_name}"
  function_name        = "${local.resource_name_prefix}-${var.lambda_function_name}"
}

# -----------------------------------------------------------------------------
# Data: aws_caller_identity gets data from current AWS account
# -----------------------------------------------------------------------------
data "aws_caller_identity" "_" {}

# -----------------------------------------------------------------------------
# Resources: Lambda Register
# -----------------------------------------------------------------------------
resource "aws_lambda_function" "_" {
  function_name                  = local.function_name
  role                           = var.lambda_role_arn
  runtime                        = var.lambda_runtime
  filename                       = var.lambda_filename
  handler                        = "handlers/${var.lambda_function_name}/index.handler"
  timeout                        = var.lambda_timeout
  memory_size                    = var.lambda_memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions

  source_code_hash = filebase64sha256("${var.dist_path}/${var.distribution_file_name}")

  layers = ["${var.lambda_layer_arn}"]

  tracing_config {
    mode = var.tracing_config_mode
  }

  environment {
    variables = var.lambda_environment_variables
  }

  tags = {
    Environment = var.namespace
    Name        = var.resource_tag_name
  }
}

resource "aws_cloudwatch_log_group" "_" {
  name              = "/aws/lambda/${local.function_name}"
  retention_in_days = var.log_retention_in_days
}

# -----------------------------------------------------------------------------
# Module: Lambda API Gateway permission
# -----------------------------------------------------------------------------
resource "aws_lambda_permission" "_" {
  count         = var.create_api_gateway_integration ? 1 : 0
  principal     = "apigateway.amazonaws.com"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function._.arn

  source_arn = "arn:aws:execute-api:${
    var.region
    }:${
    data.aws_caller_identity._.account_id
    }:${
    var.api_gateway_rest_api_id
  }/*/*"
}

# -----------------------------------------------------------------------------
# Module: SQS Queue event source
# -----------------------------------------------------------------------------
resource "aws_lambda_event_source_mapping" "_" {
  count         = var.create_sqs_integration ? 1 : 0

  event_source_arn = var.sqs_arn
  function_name    = aws_lambda_function._.arn

  batch_size = var.sqs_batch_size
}

# -----------------------------------------------------------------------------
# Module: CloudWatch Alarms Lambda
# -----------------------------------------------------------------------------
module "cloudwatch-alarms-lambda" {
  source = "./cloudwatch-alarms-lambda"

  namespace         = var.namespace
  region            = var.region
  resource_tag_name = var.resource_tag_name

  create_errorRate_alarm      = var.create_errorRate_alarm
  errorRate_threshold         = var.errorRate_threshold
  errorRate_evaluationPeriods = var.errorRate_evaluationPeriods

  create_throttleCount_alarm      = var.create_throttleCount_alarm
  throttleCount_threshold         = var.throttleCount_threshold
  throttleCount_evaluationPeriods = var.throttleCount_evaluationPeriods

  create_iteratorAge_alarm      = var.create_iteratorAge_alarm
  iteratorAge_threshold         = var.iteratorAge_threshold
  iteratorAge_evaluationPeriods = var.iteratorAge_evaluationPeriods

  create_deadLetterQueue_alarm      = var.create_deadLetterQueue_alarm
  deadLetterQueue_threshold         = var.deadLetterQueue_threshold
  deadLetterQueue_evaluationPeriods = var.deadLetterQueue_evaluationPeriods

  function_name = "${local.resource_name_prefix}-${local.function_name}"
}

# -----------------------------------------------------------------------------
# Module: SNS subscription
# -----------------------------------------------------------------------------
module "sns" {
  source = "./sns-subscription"

  namespace         = var.namespace
  region            = var.region
  resource_tag_name = var.resource_tag_name

  create_sns_topic_subscription = var.sns_topic_subscription
  sns_topic_arn                 = var.sns_topic_arn

  lambda_function_arn = aws_lambda_function._.arn
}
