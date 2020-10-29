require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Bishop
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0


    host = 'https://samurai-bishop.herokuapp.com/' # replace with your own url
    config.action_mailer.default_url_options = { host: 'https://samurai-bishop.herokuapp.com/', protocol: 'http' }

    # SMTP settings for gmail
    config.action_mailer.smtp_settings = {
      address: 'smtp.gmail.com',
      port: 587,
      user_name: 'birotori@gmail.com',
      password: 'laaysvaccbzxhesc',
      authentication: 'plain',
      enable_starttls_auto: true
    }

    config.generators do |g|
      g.assets false
      g.helper false
      g.jbuilder false
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
  end
end
