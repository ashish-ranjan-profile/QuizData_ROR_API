# app/controllers/users/omniauth_callbacks_controller.rb
class Users::OmniauthCallbacksController < ApplicationController
  def google_oauth
    token = params[:token]
    return render json: { error: "Token not present" }, status: :bad_request unless token

    validator = GoogleIDToken::Validator.new

    begin
      payload = validator.check(token, ENV["GOOGLE_CLIENT_ID"])
      email = payload["email"]

      user = User.find_or_create_by(email: email) do |u|
        u.password = SecureRandom.hex(10)
      end

      sign_in(user) # Signs in the user (Devise)

      # 🚨 Manually encode JWT token
      jwt_token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first

      render json: {
        status: { code: 200, message: "Google login successful", token: jwt_token, data: user }
      }, status: :ok

    rescue => e
      Rails.logger.error("Google login failed: #{e.message}")
      render json: { error: "Invalid token" }, status: :unauthorized
    end
  end
end
