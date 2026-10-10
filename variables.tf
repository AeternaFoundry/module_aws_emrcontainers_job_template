variable "emrcontainers_job_templates" {
  description = <<EOT
Map of emrcontainers_job_templates, attributes below
Required:
    - name
    - job_template_data (block):
        - configuration_overrides (optional, block):
            - application_configuration (optional, block):
                - classification (required)
                - configurations (optional, block):
                    - classification (optional)
                    - properties (optional)
                - properties (optional)
            - monitoring_configuration (optional, block):
                - cloud_watch_monitoring_configuration (optional, block):
                    - log_group_name (required)
                    - log_stream_name_prefix (optional)
                - persistent_app_ui (optional)
                - s3_monitoring_configuration (optional, block):
                    - log_uri (required)
        - execution_role_arn (required)
        - job_driver (required, block):
            - spark_sql_job_driver (optional, block):
                - entry_point (optional)
                - spark_sql_parameters (optional)
            - spark_submit_job_driver (optional, block):
                - entry_point (required)
                - entry_point_arguments (optional)
                - spark_submit_parameters (optional)
        - job_tags (optional)
        - release_label (required)
Optional:
    - kms_key_arn
    - region
    - tags
    - tags_all
EOT

  type = map(object({
    name        = string
    kms_key_arn = optional(string)
    region      = optional(string)
    tags        = optional(map(string))
    tags_all    = optional(map(string))
    job_template_data = object({
      configuration_overrides = optional(object({
        application_configuration = optional(list(object({
          classification = string
          configurations = optional(list(object({
            classification = optional(string)
            properties     = optional(map(string))
          })))
          properties = optional(map(string))
        })))
        monitoring_configuration = optional(object({
          cloud_watch_monitoring_configuration = optional(object({
            log_group_name         = string
            log_stream_name_prefix = optional(string)
          }))
          persistent_app_ui = optional(string)
          s3_monitoring_configuration = optional(object({
            log_uri = string
          }))
        }))
      }))
      execution_role_arn = string
      job_driver = object({
        spark_sql_job_driver = optional(object({
          entry_point          = optional(string)
          spark_sql_parameters = optional(string)
        }))
        spark_submit_job_driver = optional(object({
          entry_point             = string
          entry_point_arguments   = optional(set(string))
          spark_submit_parameters = optional(string)
        }))
      })
      job_tags      = optional(map(string))
      release_label = string
    })
  }))
  validation {
    condition = alltrue([
      for k, v in var.emrcontainers_job_templates : (
        v.job_template_data.configuration_overrides == null || (v.job_template_data.configuration_overrides.application_configuration == null || (length(v.job_template_data.configuration_overrides.application_configuration) <= 100))
      )
    ])
    error_message = "Each application_configuration list must contain at most 100 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.emrcontainers_job_templates : (
        v.job_template_data.configuration_overrides == null || (v.job_template_data.configuration_overrides.application_configuration == null || alltrue([for item in v.job_template_data.configuration_overrides.application_configuration : (item.configurations == null || (length(item.configurations) <= 100))]))
      )
    ])
    error_message = "Each configurations list must contain at most 100 items"
  }
  # Note: 4 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

