
variable "aws_appautoscaling_target_config" {
  type        = map(string)
  description = <<EOL
    Settings for AWS Appautoscaling Target
    JSON tfvars Exmaple:
    "aws_appautoscaling_target_config": {
        "max_capacity"       : 100,
        "min_capacity"       : 5,
        "resource_id"        : "table/MyTable", #more info: https://docs.aws.amazon.com/autoscaling/application/APIReference/API_RegisterScalableTarget.html#autoscaling-RegisterScalableTarget-request-ResourceId
        "scalable_dimension" : "dynamodb:table:ReadCapacityUnits", #more info: https://docs.aws.amazon.com/autoscaling/application/APIReference/API_RegisterScalableTarget.html#autoscaling-RegisterScalableTarget-request-ScalableDimension
        "service_namespace"  : "dynamodb" #more info: https://docs.aws.amazon.com/autoscaling/application/APIReference/API_RegisterScalableTarget.html#autoscaling-RegisterScalableTarget-request-ServiceNamespace
    }
    EOL
}

variable "aws_appautoscaling_policy_config" {
  type = object({
    policy_type = string
    step_scaling_policy_configurations = list(object({
      cooldown                 = string
      metric_aggregation_type  = string
      min_adjustment_magnitude = string
      step_adjustment          = list(map(string))
    }))
    target_tracking_scaling_policy_configurations = list(object({
      target_value       = number
      disable_scale_in   = string
      scale_in_cooldown  = string
      scale_out_cooldown = string
      customized_metric_specifications = list(object({
        metric_name = string
        namespace   = string
        statistic   = string
        unit        = string
        dimensions  = list(map(string))
      }))
      predefined_metric_specifications = list(map(string))
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


#   dynamic "step_scaling_policy_configuration" {
#     for_each = lookup(var.aws_appautoscaling_policy_config, "step_scaling_policy_configurations", {})
#     content {
#       adjustment_type          = step_scaling_policy_configuration.value["adjustment_type"]
#       cooldown                 = step_scaling_policy_configuration.value["cooldown"]
#       metric_aggregation_type  = lookup(step_scaling_policy_configuration.value, "metric_aggregation_type", null)
#       min_adjustment_magnitude = lookup(step_scaling_policy_configuration.value, "min_adjustment_magnitude", null)
#       dynamic "step_adjustment" {
#         for_each = lookup(step_scaling_policy_configuration.value, "step_adjustment", {})
#         content {
#           metric_interval_lower_bound = lookup(step_adjustment.value, "metric_interval_lower_bound", null)
#           metric_interval_upper_bound = lookup(step_adjustment.value, "metric_interval_upper_bound", null)
#           scaling_adjustment          = step_adjustment.value["scaling_adjustment"]
#         }
#       }

#     }
#   }

#   dynamic "target_tracking_scaling_policy_configuration" {
#     for_each = lookup(var.aws_appautoscaling_policy_config, "target_tracking_scaling_policy_configurations", {})
#     content {
#       target_value       = target_tracking_scaling_policy_configuration.value["target_value"]
#       disable_scale_in   = lookup(target_tracking_scaling_policy_configuration.value, "disable_scale_in", null)
#       scale_in_cooldown  = lookup(target_tracking_scaling_policy_configuration.value, "scale_in_cooldown", null)
#       scale_out_cooldown = lookup(target_tracking_scaling_policy_configuration.value, "scale_out_cooldown", null)
#       dynamic "customized_metric_specification" {
#         for_each = lookup(target_tracking_scaling_policy_configuration.value, "customized_metric_specification", [])
#         content {
#           dynamic "dimensions" {
#             for_each = lookup(customized_metric_specification.value, "dimensions", [])
#             content {
#               name  = dimensions.value["name"]
#               value = dimensions.value["value"]
#             }
#           }
#           metric_name = customized_metric_specification.value["metric_name"]
#           namespace   = customized_metric_specification.value["namespace"]
#           statistic   = customized_metric_specification.value["statistic"]
#           unit        = lookup(customized_metric_specification.value, "unit", {})
#         }
#       }
#       dynamic "predefined_metric_specification" {
#         for_each = lookup(target_tracking_scaling_policy_configuration.value, "predefined_metric_specification", [])
#         content {
#           predefined_metric_type = predefined_metric_specification.value["predefined_metric_type"]
#           resource_label         = lookup(predefined_metric_specification.value, "resource_label", null)
#         }

#       }
#     }
#   }