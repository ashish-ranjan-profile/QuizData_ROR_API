require "google-id-token"

class Users::OmniauthController < ApplicationController
skip_before_action :verify_authenticity_token, raise: false

  def google_token
    token = params[:credential]

    validator = GoogleIDToken::Validator.new
    client_id = ENV["GOOGLE_CLIENT_ID"]

    begin
      payload = validator.check(token, client_id)

      user = User.find_or_create_by!(email: payload["email"]) do |u|
        u.password = SecureRandom.hex(15)
      end

      sign_in(user)
      render json: { user: user, message: "Signed in successfully" }, status: :ok

    rescue => e
      render json: { error: "Invalid token: #{e.message}" }, status: :unauthorized
    end
  end
end
