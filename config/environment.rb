# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
ApiContexel::Application.default_url_options = ApiContexel::Application.config.default_url_options
