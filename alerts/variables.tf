# General Variables
variable "application_name" {
  type        = string
  description = "The name of the application in New Relic."
}

variable "account_id" {
  type        = string
  description = "New Relic account ID."
}

variable "runbook_url" {
  type        = string
  default     = null
  description = "URL for the runbook used in alert conditions."
}

variable "incident_preference" {
  type        = string
  default     = "PER_POLICY"
  description = "Incident preference for the alert policy (PER_POLICY, PER_CONDITION, PER_CONDITION_AND_TARGET)."
}

variable "channel_ids" {
  type        = list(string)
  description = "List of alert channel IDs to attach to the policy."
}

# Error Rate Condition
variable "error_rate_warning_threshold" {
  type        = number
  description = "Warning threshold for error rate."
}

variable "error_rate_critical_threshold" {
  type        = number
  description = "Critical threshold for error rate."
}

variable "error_rate_duration" {
  type        = number
  description = "Duration in seconds for error rate alert condition."
}

# Response Time Condition
variable "response_time_warning_threshold" {
  type        = number
  description = "Warning threshold for response time."
}

variable "response_time_critical_threshold" {
  type        = number
  default     = null
  description = "Critical threshold for response time."
}

variable "response_time_duration" {
  type        = number
  description = "Duration in seconds for response time alert condition."
}
