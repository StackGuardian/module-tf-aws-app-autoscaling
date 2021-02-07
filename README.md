# module-tf-aws-app-autoscaling
Terraform module for AWS Application Autoscaling

----

## Terraform Registry
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy

----

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_appautoscaling\_policy\_config | Settings for AWS Appautoscaling Policy<br>    JSON tfvars Exmaple:<br>    "aws\_appautoscaling\_policy\_config": {<br>        "policy\_type": "TargetTrackingScaling",<br>        "target\_tracking\_scaling\_policy\_configurations": [<br>            {<br>                "target\_value": 70,<br>                "predefined\_metric\_specifications": [<br>                    {<br>                        "predefined\_metric\_type": "DynamoDBReadCapacityUtilization"<br>                    }<br>                ]<br>            }<br>        ],<br>        "step\_scaling\_policy\_configurations": []<br>    } | <pre>object({<br>    policy_type = string<br>    step_scaling_policy_configurations = list(object({<br>      cooldown                 = string<br>      metric_aggregation_type  = string<br>      min_adjustment_magnitude = string<br>      step_adjustment          = list(map(string))<br>    }))<br>    target_tracking_scaling_policy_configurations = list(object({<br>      target_value       = number<br>      disable_scale_in   = string<br>      scale_in_cooldown  = string<br>      scale_out_cooldown = string<br>      customized_metric_specifications = list(object({<br>        metric_name = string<br>        namespace   = string<br>        statistic   = string<br>        unit        = string<br>        dimensions  = list(map(string))<br>      }))<br>      predefined_metric_specifications = list(map(string))<br>    }))<br>  })</pre> | `null` | no |
| aws\_appautoscaling\_target\_config | Settings for AWS Appautoscaling Target<br>    JSON tfvars Exmaple:<br>    "aws\_appautoscaling\_target\_config": {<br>        "max\_capacity"       : 100,<br>        "min\_capacity"       : 5,<br>        "resource\_id"        : "table/MyTable", #more info: https://docs.aws.amazon.com/autoscaling/application/APIReference/API_RegisterScalableTarget.html#autoscaling-RegisterScalableTarget-request-ResourceId<br>        "role\_arn"           : "arn:......."<br>        "scalable\_dimension" : "dynamodb:table:ReadCapacityUnits", #more info: https://docs.aws.amazon.com/autoscaling/application/APIReference/API_RegisterScalableTarget.html#autoscaling-RegisterScalableTarget-request-ScalableDimension<br>        "service\_namespace"  : "dynamodb" #more info: https://docs.aws.amazon.com/autoscaling/application/APIReference/API_RegisterScalableTarget.html#autoscaling-RegisterScalableTarget-request-ServiceNamespace<br>    } | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN assigned by AWS to the scaling policy |
| name | The scaling policy's name |
| policy\_type | The scaling policy's type |