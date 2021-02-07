output "arn" {
  value       = aws_appautoscaling_policy.main.arn
  sensitive   = false
  description = "The ARN assigned by AWS to the scaling policy"
  depends_on  = []
}

output "name" {
  value       = aws_appautoscaling_policy.main.name
  sensitive   = false
  description = "The scaling policy's name"
  depends_on  = []
}

output "policy_type" {
  value       = aws_appautoscaling_policy.main.policy_type
  sensitive   = false
  description = "The scaling policy's type"
  depends_on  = []
}
