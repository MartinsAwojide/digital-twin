project_name             = "twin"
environment              = "dev"
resource_suffix          = "auto"
bedrock_model_id         = "us.amazon.nova-2-lite-v1:0"
lambda_timeout           = 60
api_throttle_burst_limit = 10
api_throttle_rate_limit  = 5
use_custom_domain        = false
root_domain              = ""

# Copy OPENROUTER_API_KEY from twin/.env (do not commit real values). Or: export TF_VAR_openrouter_api_key="..."
openrouter_api_key = "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"
