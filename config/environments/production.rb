require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Code eager load
  config.eager_load = true
  config.consider_all_requests_local = false

  # Cache
  config.action_controller.perform_caching = true
  config.cache_store = :memory_store

  # File storage (change if using S3 or cloud)
  config.active_storage.service = :local

  # Mailer settings
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: "yourdomain.com", protocol: "https" }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              "smtp.gmail.com",
    port:                 587,
    domain:               "gmail.com",
    user_name:            ENV["SMTP_EMAIL"],
    password:             ENV["SMTP_PASSWORD"],
    authentication:       "plain",
    enable_starttls_auto: true
  }

  # Logs
  config.log_level = :info
  config.log_tags  = [ :request_id ]

  # Asset management
  config.assets.compile = false

  # I18n fallback
  config.i18n.fallbacks = true

  # Logging formatter
  config.log_formatter = ::Logger::Formatter.new

  # STDOUT logger for servers
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Database migrations error
  config.active_record.dump_schema_after_migration = false
end
