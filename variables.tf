
variable bucket {
  description = "bucket"
}

variable certificate_arn {
  description = "Arn of the ssl certificate"
}

variable lambda_arn {
  description = "Arn of the lambda"
  type        = string
}

variable default_root_object {
  description = "Default root object of the distribution"
  default     = null
}

variable domain_name {
  type = string
}

variable record_type {
  type = string
}

variable zone_name {
  type = string
}
