# CloudFront module with Route53 record

Terraform Module that implements a CloudFront Distribution (CDN) for a custom origin ( e.g website)

## Inputs

| Name                | Description                                              |  Type  | Default  | Required |
| ------------------- | -------------------------------------------------------- | :----: | :------: | :------: |
| bucket              | Existing s3 Bucket value configured as static website    | string | `` | yes |
| certificate_arn     | Existing ACM Certificate ARN                             | string | `` | yes |
| lambda_arn          | Existing lambda function ARN                             | string | `` |yes  |
| default_root_object | Object that CloudFront return when requests the root URL | string |   null   |    no    |
| domain_name         | ID of the hosted domain to contain this record           | string | `` | yes |
| record_type         | Type of the route53 record                               | string | `` | yes |
| zone_name           | Name of the hosted zone to contain this record           | string | `` | yes |

## Outputs

| Name              | Description              |
| ----------------- | ------------------------ |
| distribution_name | The name of distribution |
