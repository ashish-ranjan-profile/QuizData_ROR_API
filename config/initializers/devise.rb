# frozen_string_literal: true

Devise.setup do |config|
  # ==> Mailer Configuration
  config.mailer_sender = "please-change-me@example.com"
  require "devise/orm/active_record"

  # ==> Authentication Configuration
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [ :http_auth ]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.sign_out_via = :delete

  # API-only setup: disable navigational formats
  config.navigational_formats = []

  # ==> JWT Configuration
  jwt_secret = ENV["DEVISE_JWT_SECRET_KEY"]
  if jwt_secret.blank?
    raise "DEVISE_JWT_SECRET_KEY environment variable is missing!"
  end

  config.jwt do |jwt|
    jwt.secret = jwt_secret
    jwt.dispatch_requests = [
      [ "POST", %r{^/users/sign_in$} ],
      [ "POST", %r{^/users$} ]
    ]
    jwt.revocation_requests = [
      [ "DELETE", %r{^/users/sign_out$} ]
    ]
    jwt.expiration_time = 1.day.to_i
  end

  # ==> OmniAuth (Google OAuth2)
  google_client_id     = ENV["GOOGLE_CLIENT_ID"]
  google_client_secret = ENV["GOOGLE_CLIENT_SECRET"]

  if google_client_id.present? && google_client_secret.present?
    config.omniauth :google_oauth2,
                    google_client_id,
                    google_client_secret,
                    scope: "userinfo.email,userinfo.profile",
                    access_type: "offline"
  end
end
