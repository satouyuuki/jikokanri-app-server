# Aws.config.update{
#   credentials: Aws::Credentials.new('your_access_key_id', 'your_secret_access_key')
# }
# Aws.config.update(Rails.application.config_for(:aws).deep_symbolize_keys)