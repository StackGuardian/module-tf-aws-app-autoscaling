# module-tf-aws-app-autoscaling
Terraform module for AWS Application Autoscaling


## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws\_appautoscaling\_policy\_config | Settings for AWS Appautoscaling Policy     JSON tfvars Exmaple:     "aws\_appautoscaling\_policy\_config": {         "policy\_type": "TargetTrackingScaling",         "target\_tracking\_scaling\_policy\_configurations": [             {                 "target\_value": 70,                 "predefined\_metric\_specifications": [                     {                         "predefined\_metric\_type": "DynamoDBReadCapacityUtilization"                     }                 ]             }         ],         "step\_scaling\_policy\_configurations": []     } | <pre>object({<br>    policy_type = string<br>    step_scaling_policy_configurations = list(object({<br>      cooldown                 = string<br>      metric_aggregation_type  = string<br>      min_adjustment_magnitude = string<br>      step_adjustment          = list(map(string))<br>    }))<br>    target_tracking_scaling_policy_configurations = list(object({<br>      target_value       = number<br>      disable_scale_in   = string<br>      scale_in_cooldown  = string<br>      scale_out_cooldown = string<br>      customized_metric_specifications = list(object({<br>        metric_name = string<br>        namespace   = string<br>        statistic   = string<br>        unit        = string<br>        dimensions  = list(map(string))<br>      }))<br>      predefined_metric_specifications = list(map(string))<br>    }))<br>  })</pre> | n/a | yes |
| aws\_appautoscaling\_target\_config | Settings for AWS Appautoscaling Target     JSON tfvars Exmaple:     "aws\_appautoscaling\_target\_config": {         "max\_capacity"       : 100,         "min\_capacity"       : 5,         "resource\_id"        : "table/MyTable", #more info: https://docs.aws.amazon.com/autoscaling/application/APIReference/API_RegisterScalableTarget.html#autoscaling-RegisterScalableTarget-request-ResourceId         "role\_arn"           : "arn:......."         "scalable\_dimension" : "dynamodb:table:ReadCapacityUnits", #more info: https://docs.aws.amazon.com/autoscaling/application/APIReference/API_RegisterScalableTarget.html#autoscaling-RegisterScalableTarget-request-ScalableDimension         "service\_namespace"  : "dynamodb" #more info: https://docs.aws.amazon.com/autoscaling/application/APIReference/API_RegisterScalableTarget.html#autoscaling-RegisterScalableTarget-request-ServiceNamespace     } | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| policy\_arns | The ARN assigned by AWS to the scaling policy. |
| policy\_names | The scaling policy's name. |
| policy\_types | The scaling policy's type. |