resource "newrelic_alert_policy" "policy" {
  name                ="poc"
  incident_preference = var.incident_preference
}

# Error Rate Condition
resource "newrelic_nrql_alert_condition" "error_rate_condition" {
  policy_id = newrelic_alert_policy.policy.id

  name        = "Error rate (High)"
  type        = "static"
  runbook_url = var.runbook_url
  enabled     = true

  critical {
    operator              = "above"
    threshold             = var.error_rate_critical_threshold
    threshold_duration    = var.error_rate_duration
    threshold_occurrences = "ALL"
  }

  warning {
    operator              = "above"
    threshold             = var.error_rate_warning_threshold
    threshold_duration    = var.error_rate_duration
    threshold_occurrences = "ALL"
  }

  nrql {
    query             = "SELECT percentage(count(*), WHERE error IS TRUE) FROM Transaction WHERE appName = '${var.application_name}' AND accountId = ${var.account_id}"
    evaluation_offset = 3
  }

  value_function       = "single_value"
  violation_time_limit = "ONE_HOUR"
}

# Response Time Condition
resource "newrelic_nrql_alert_condition" "response_time_condition" {
  count = var.response_time_critical_threshold == null ? 0 : 1

  policy_id = newrelic_alert_policy.policy.id

  name        = "Response time (High)"
  type        = "static"
  runbook_url = var.runbook_url
  enabled     = true

  warning {
    operator              = "above"
    threshold             = var.response_time_warning_threshold
    threshold_duration    = var.response_time_duration
    threshold_occurrences = "ALL"
  }

  critical {
    operator              = "above"
    threshold             = var.response_time_critical_threshold
    threshold_duration    = var.response_time_duration
    threshold_occurrences = "ALL"
  }

  nrql {
    query             = "SELECT average(duration) FROM Transaction WHERE appName = '${var.application_name}' AND accountId = ${var.account_id}"
    evaluation_offset = 3
  }

  value_function       = "single_value"
  violation_time_limit = "ONE_HOUR"
}
