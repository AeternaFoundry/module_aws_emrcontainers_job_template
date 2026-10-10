output "emrcontainers_job_templates_id" {
  description = "Map of id values across all emrcontainers_job_templates, keyed the same as var.emrcontainers_job_templates"
  value       = { for k, v in aws_emrcontainers_job_template.emrcontainers_job_templates : k => v.id if v.id != null && length(v.id) > 0 }
}
output "emrcontainers_job_templates_arn" {
  description = "Map of arn values across all emrcontainers_job_templates, keyed the same as var.emrcontainers_job_templates"
  value       = { for k, v in aws_emrcontainers_job_template.emrcontainers_job_templates : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "emrcontainers_job_templates_job_template_data" {
  description = "Map of job_template_data values across all emrcontainers_job_templates, keyed the same as var.emrcontainers_job_templates"
  value       = { for k, v in aws_emrcontainers_job_template.emrcontainers_job_templates : k => one(v.job_template_data) if v.job_template_data != null && length(v.job_template_data) > 0 }
}
output "emrcontainers_job_templates_kms_key_arn" {
  description = "Map of kms_key_arn values across all emrcontainers_job_templates, keyed the same as var.emrcontainers_job_templates"
  value       = { for k, v in aws_emrcontainers_job_template.emrcontainers_job_templates : k => v.kms_key_arn if v.kms_key_arn != null && length(v.kms_key_arn) > 0 }
}
output "emrcontainers_job_templates_name" {
  description = "Map of name values across all emrcontainers_job_templates, keyed the same as var.emrcontainers_job_templates"
  value       = { for k, v in aws_emrcontainers_job_template.emrcontainers_job_templates : k => v.name if v.name != null && length(v.name) > 0 }
}
output "emrcontainers_job_templates_region" {
  description = "Map of region values across all emrcontainers_job_templates, keyed the same as var.emrcontainers_job_templates"
  value       = { for k, v in aws_emrcontainers_job_template.emrcontainers_job_templates : k => v.region if v.region != null && length(v.region) > 0 }
}
output "emrcontainers_job_templates_tags" {
  description = "Map of tags values across all emrcontainers_job_templates, keyed the same as var.emrcontainers_job_templates"
  value       = { for k, v in aws_emrcontainers_job_template.emrcontainers_job_templates : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "emrcontainers_job_templates_tags_all" {
  description = "Map of tags_all values across all emrcontainers_job_templates, keyed the same as var.emrcontainers_job_templates"
  value       = { for k, v in aws_emrcontainers_job_template.emrcontainers_job_templates : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}

