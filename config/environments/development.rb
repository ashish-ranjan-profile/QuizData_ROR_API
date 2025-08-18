require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Code reload without server restart
  config.enable_reloading = true
  config.eager_load = false

  # Full error reports
  config.consider_all_requests_local = true
  config.server_timing = true

  # Cache disabled
  config.action_controller.perform_caching = false
  config.cache_store = :memory_store

  # File storage local
  config.active_storage.service = :local

  # Mailer settings
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: "localhost", port: 3000 }

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

  # Logs and debug
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.active_record.query_log_tags_enabled = true
  config.active_job.verbose_enqueue_logs = true
  config.action_view.annotate_rendered_view_with_filenames = true
  config.action_controller.raise_on_missing_callback_actions = true
end
