variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "Project name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be one of: dev, test, prod."
  }
}

variable "resource_suffix" {
  description = "Optional suffix appended to {project_name}-{environment} for parallel stacks (e.g. auto). Leave empty for the default prefix."
  type        = string
  default     = ""
  validation {
    condition     = var.resource_suffix == "" || can(regex("^[a-z0-9-]+$", var.resource_suffix))
    error_message = "resource_suffix must be empty or contain only lowercase letters, numbers, and hyphens."
  }
}

variable "bedrock_model_id" {
  description = "Bedrock model ID"
  type        = string
  default     = "amazon.nova-micro-v1:0"
}

variable "lambda_timeout" {
  description = "Lambda function timeout in seconds"
  type        = number
  default     = 60
}

variable "api_throttle_burst_limit" {
  description = "API Gateway throttle burst limit"
  type        = number
  default     = 10
}

variable "api_throttle_rate_limit" {
  description = "API Gateway throttle rate limit"
  type        = number
  default     = 5
}

variable "use_custom_domain" {
  description = "Attach a custom domain to CloudFront"
  type        = bool
  default     = false
}

variable "root_domain" {
  description = "Apex domain name, e.g. mydomain.com"
  type        = string
  default     = ""
}

variable "openrouter_api_key" {
  description = "OpenRouter API key for Bedrock fallback (same as OPENROUTER_API_KEY in .env). Leave empty to omit from Lambda. Prefer TF_VAR_openrouter_api_key instead of committing secrets."
  type        = string
  default     = ""
  sensitive   = true
}

