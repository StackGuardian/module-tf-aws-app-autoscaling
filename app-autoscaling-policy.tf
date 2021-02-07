resource "aws_appautoscaling_policy" "main" {
  depends_on         = [var.aws_appautoscaling_policy_config]
  name               = aws_appautoscaling_target.main.resource_id
  policy_type        = lookup(var.aws_appautoscaling_policy_config, "policy_type", null)
  resource_id        = aws_appautoscaling_target.main.resource_id
  scalable_dimension = aws_appautoscaling_target.main.scalable_dimension
  service_namespace  = aws_appautoscaling_target.main.service_namespace

  dynamic "step_scaling_policy_configuration" {
    for_each = lookup(var.aws_appautoscaling_policy_config, "step_scaling_policy_configurations", [])
    content {
      adjustment_type          = step_scaling_policy_configuration.value["adjustment_type"]
      cooldown                 = step_scaling_policy_configuration.value["cooldown"]
      metric_aggregation_type  = lookup(step_scaling_policy_configuration.value, "metric_aggregation_type", null)
      min_adjustment_magnitude = lookup(step_scaling_policy_configuration.value, "min_adjustment_magnitude", null)
      dynamic "step_adjustment" {
        for_each = lookup(step_scaling_policy_configuration.value, "step_adjustments", [])
        content {
          metric_interval_lower_bound = lookup(step_adjustment.value, "metric_interval_lower_bound", null)
          metric_interval_upper_bound = lookup(step_adjustment.value, "metric_interval_upper_bound", null)
          scaling_adjustment          = step_adjustment.value["scaling_adjustment"]
        }
      }

    }
  }

  dynamic "target_tracking_scaling_policy_configuration" {
    for_each = lookup(var.aws_appautoscaling_policy_config, "target_tracking_scaling_policy_configurations", [])
    content {
      target_value       = target_tracking_scaling_policy_configuration.value["target_value"]
      disable_scale_in   = lookup(target_tracking_scaling_policy_configuration.value, "disable_scale_in", null)
      scale_in_cooldown  = lookup(target_tracking_scaling_policy_configuration.value, "scale_in_cooldown", null)
      scale_out_cooldown = lookup(target_tracking_scaling_policy_configuration.value, "scale_out_cooldown", null)
      dynamic "customized_metric_specification" {
        for_each = lookup(target_tracking_scaling_policy_configuration.value, "customized_metric_specifications", [])
        content {
          dynamic "dimensions" {
            for_each = lookup(customized_metric_specification.value, "dimensions", [])
            content {
              name  = dimensions.value["name"]
              value = dimensions.value["value"]
            }
          }
          metric_name = customized_metric_specification.value["metric_name"]
          namespace   = customized_metric_specification.value["namespace"]
          statistic   = customized_metric_specification.value["statistic"]
          unit        = lookup(customized_metric_specification.value, "unit", null)
        }
      }
      dynamic "predefined_metric_specification" {
        for_each = lookup(target_tracking_scaling_policy_configuration.value, "predefined_metric_specifications", [])
        content {
          predefined_metric_type = predefined_metric_specification.value["predefined_metric_type"]
          resource_label         = lookup(predefined_metric_specification.value, "resource_label", null)
        }

      }
    }
  }

}