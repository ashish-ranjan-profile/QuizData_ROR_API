# frozen_string_literal: true

require "devise"

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

 def respond_with(resource, _options = {})
  token = request.env["warden-jwt_auth.token"]  # 👈 yahan se JWT token milega

  if resource && token
    render json: {
      status: {
        code: 200,
        message: "User successfully signed in",
        token: token,  # 👈 token ko include karo
        data: resource
      }
    }, status: :ok
  else
    render json: {
      status: {
        code: 401,
        message: "Login failed",
        errors: [ "Invalid credentials or token missing" ]
      }
    }, status: :unauthorized
  end
 end


  # Custom response after logout
  def respond_to_on_destroy
    token = request.headers["Authorization"]&.split(" ")&.last

    if token.blank?
      render json: { status: 401, message: "Missing or invalid token" }, status: :unauthorized
      return
    end

    begin
      jwt_payload = JWT.decode(
        token,
        Rails.application.credentials.dig(:devise, :jwt_secret_key),
        true,
        algorithm: "HS256"
      ).first

      current_user = User.find(jwt_payload["sub"])

      if current_user
        render json: {
          status: 200,
          message: "Signed out successfully"
        }, status: :ok
      else
        render json: {
          status: 401,
          message: "User not found"
        }, status: :unauthorized
      end
    rescue JWT::DecodeError => e
      render json: {
        status: 401,
        message: "Invalid or expired token",
        error: e.message
      }, status: :unauthorized
    end
  end
end
