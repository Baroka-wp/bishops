require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Bishop
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.secret_key_base = 'fa39a99ce1e07233dd84b0cc87476bd3a39cd745e12caafc1518c197d15c31f3c7d5aa29c53b9f9ee4d01d371da50b2373db6485f238d9364162867aae2f68be'

    #host = 'localhost:3000' # replace with your own url
    #config.action_mailer.default_url_options = { host: 'localhost:3000', protocol: 'http' }

    host = 'http://bishop-samurai.herokuapp.com/'
    config.action_mailer.default_url_options = { host: 'http://bishop-samurai.herokuapp.com/', protocol: 'http' }
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
