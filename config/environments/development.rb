Rails.application.configure do
  config.cache_classes = false
  config.force_ssl = false
  config.eager_load = false

  config.consider_all_requests_local = false
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.active_storage.service = :local
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.assets.debug = true
  config.assets.quiet = true
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.action_mailer.delivery_method = :smtp
  #host = 'localhost:3000' # replace with your own url
  config.action_mailer.default_url_options = { host: 'localhost:3000', protocol: 'http' }

  host = 'https://samurai-bishop.herokuapp.com/' # replace with your own url
  #config.action_mailer.default_url_options = { host: 'https://samurai-bishop.herokuapp.com/', protocol: 'http' }

  # SMTP settings for gmail
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    user_name: 'birotori@gmail.com',
    password: 'laaysvaccbzxhesc',
    authentication: 'plain',
    enable_starttls_auto: true
  }
end
