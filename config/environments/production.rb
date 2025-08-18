require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Eager load code on boot
  config.eager_load = true

  # Show user-friendly errors (not full stacktrace in prod)
  config.consider_all_requests_local = false

  # Caching
  config.action_controller.perform_caching = true
  config.cache_store = :memory_store

  # Active Storage (local, change if using S3 or Cloudinary)
  config.active_storage.service = :local

  # Mailer
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: ENV["APP_HOST"] || "yourdomain.com", protocol: "https" }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              "smtp.gmail.com",
    port:                 587,
    domain:               "gmail.com",
    user_name:             Rails.application.credentials.dig(:smtp, :email),
    password:             Rails.application.credentials.dig(:smtp, :password),
    authentication:       "plain",
    enable_starttls_auto: true
  }

  # Logs
  config.log_level = :info
  config.log_tags  = [ :request_id ]

  # I18n fallback
  config.i18n.fallbacks = true

  # Logging formatter
  config.log_formatter = ::Logger::Formatter.new

  # STDOUT logger for deployment (Render, Railway, Heroku, etc.)
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migration
  config.active_record.dump_schema_after_migration = false
end
