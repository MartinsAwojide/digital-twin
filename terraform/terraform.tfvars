project_name             = "twin"
environment              = "dev"
resource_suffix          = "auto"
bedrock_model_id         = "us.amazon.nova-2-lite-v1:0"
lambda_timeout           = 60
api_throttle_burst_limit = 10
api_throttle_rate_limit  = 5
use_custom_domain        = false
root_domain              = ""

# OpenRouter (Bedrock fallback): do not set openrouter_api_key here — it overrides TF_VAR_*.
# CI: GitHub secret OPENROUTER_API_KEY → TF_VAR_openrouter_api_key. Local: export TF_VAR_openrouter_api_key=...
