# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
config.action_mailer.default_url_options = { host: 'https://samurai-bishop.herokuapp.com/' }
config.action_mailer.delivery_method = :smtp

config.action_mailer.smtp_settings = {
  address: 'smtp.gmail.com',
  port: 587,
  user_name: 'birotori@gmail.com',
  password: 'rikaelbiz',
  authentication: 'plain',
  enable_starttls_auto: true
}
