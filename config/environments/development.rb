Glodjib::Application.configure do
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  # Make on-the-fly changes possible
  config.eager_load = false

  # ActionMailer config
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
end

Glodjib::Application.config.middleware.use ExceptionNotification::Rack,
  :email => {
    :email_prefix => "[Exception] ",
    :sender_address => %{"notifier" <notifier@glodjib.ch>},
    :exception_recipients => %w{haslo@haslo.ch},
    :normalize_subject => true
  }

Paperclip.options[:command_path] = "/usr/local/bin/"
