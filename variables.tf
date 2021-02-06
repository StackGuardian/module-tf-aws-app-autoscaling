
variable "aws_appautoscaling_target_config" {
  type        = map(string)
  description = <<EOL
    Settings for AWS Appautoscaling Target
    JSON tfvars Exmaple:
    "aws_appautoscaling_target_config": {
        "max_capacity"       : 100,
        "min_capacity"       : 5,
        "resource_id"        : "table/MyTable",
        "scalable_dimension" : "dynamodb:table:ReadCapacityUnits", #more info: https://docs.aws.amazon.com/autoscaling/application/APIReference/API_RegisterScalableTarget.html#autoscaling-RegisterScalableTarget-request-ScalableDimension
        "service_namespace"  : "dynamodb" #more info: https://docs.aws.amazon.com/autoscaling/application/APIReference/API_RegisterScalableTarget.html#autoscaling-RegisterScalableTarget-request-ServiceNamespace
    }
    EOL
}

variable "aws_appautoscaling_policy_config" {
  type = object({
    policy_type  = string
    target_value = number
    target_tracking_scaling_policy_configuration = list(object({
      predefined_metric_specification = list(map(any))
    }))
  })
  description = <<EOL
    Settings for AWS Appautoscaling Policy
    JSON tfvars Exmaple:
    "aws_appautoscaling_policy_config": {
        "name"               : "DynamoDBReadCapacityUtilizationMyTable"
        "policy_type"        : "TargetTrackingScaling"

        "target_tracking_scaling_policy_configuration" : [{
        "predefined_metric_specification" : [{
            predefined_metric_type : "DynamoDBReadCapacityUtilization"
        }]]

        "target_value": 70
        }
    }
    EOL
  default     = null
}
