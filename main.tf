resource "aws_emrcontainers_job_template" "emrcontainers_job_templates" {
  for_each = var.emrcontainers_job_templates

  name        = each.value.name
  kms_key_arn = each.value.kms_key_arn
  region      = each.value.region
  tags        = each.value.tags
  tags_all    = each.value.tags_all

  job_template_data {
    dynamic "configuration_overrides" {
      for_each = each.value.job_template_data.configuration_overrides != null ? [each.value.job_template_data.configuration_overrides] : []
      content {
        dynamic "application_configuration" {
          for_each = configuration_overrides.value.application_configuration != null ? configuration_overrides.value.application_configuration : []
          content {
            classification = application_configuration.value.classification
            dynamic "configurations" {
              for_each = application_configuration.value.configurations != null ? application_configuration.value.configurations : []
              content {
                classification = configurations.value.classification
                properties     = configurations.value.properties
              }
            }
            properties = application_configuration.value.properties
          }
        }
        dynamic "monitoring_configuration" {
          for_each = configuration_overrides.value.monitoring_configuration != null ? [configuration_overrides.value.monitoring_configuration] : []
          content {
            dynamic "cloud_watch_monitoring_configuration" {
              for_each = monitoring_configuration.value.cloud_watch_monitoring_configuration != null ? [monitoring_configuration.value.cloud_watch_monitoring_configuration] : []
              content {
                log_group_name         = cloud_watch_monitoring_configuration.value.log_group_name
                log_stream_name_prefix = cloud_watch_monitoring_configuration.value.log_stream_name_prefix
              }
            }
            persistent_app_ui = monitoring_configuration.value.persistent_app_ui
            dynamic "s3_monitoring_configuration" {
              for_each = monitoring_configuration.value.s3_monitoring_configuration != null ? [monitoring_configuration.value.s3_monitoring_configuration] : []
              content {
                log_uri = s3_monitoring_configuration.value.log_uri
              }
            }
          }
        }
      }
    }
    execution_role_arn = each.value.job_template_data.execution_role_arn
    job_driver {
      dynamic "spark_sql_job_driver" {
        for_each = each.value.job_template_data.job_driver.spark_sql_job_driver != null ? [each.value.job_template_data.job_driver.spark_sql_job_driver] : []
        content {
          entry_point          = spark_sql_job_driver.value.entry_point
          spark_sql_parameters = spark_sql_job_driver.value.spark_sql_parameters
        }
      }
      dynamic "spark_submit_job_driver" {
        for_each = each.value.job_template_data.job_driver.spark_submit_job_driver != null ? [each.value.job_template_data.job_driver.spark_submit_job_driver] : []
        content {
          entry_point             = spark_submit_job_driver.value.entry_point
          entry_point_arguments   = spark_submit_job_driver.value.entry_point_arguments
          spark_submit_parameters = spark_submit_job_driver.value.spark_submit_parameters
        }
      }
    }
    job_tags      = each.value.job_template_data.job_tags
    release_label = each.value.job_template_data.release_label
  }
}

