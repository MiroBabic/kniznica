# Load the Rails application.
require_relative 'application'

#load env with username and pass for email
app_env_vars = File.join(Rails.root, 'config', 'initializers', 'app_env_vars.rb')
load(app_env_vars) if File.exists?(app_env_vars)
# Initialize the Rails application.
Rails.application.initialize!
