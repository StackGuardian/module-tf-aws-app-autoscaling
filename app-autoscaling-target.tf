resource "aws_appautoscaling_target" "main" {
  max_capacity       = var.aws_appautoscaling_target_config["max_capacity"]
  min_capacity       = var.aws_appautoscaling_target_config["min_capacity"]
  resource_id        = var.aws_appautoscaling_target_config["resource_id"]
  role_arn           = lookup(var.aws_appautoscaling_target_config, "role_arn", null)
  scalable_dimension = var.aws_appautoscaling_target_config["scalable_dimension"]
  service_namespace  = var.aws_appautoscaling_target_config["service_namespace"]
}