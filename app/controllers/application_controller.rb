class ApplicationController < ActionController::API
  def authenticate_user!
    header = request.headers["Authorization"]
    return render json: { error: "Missing token" }, status: :unauthorized unless header

    token = header.split(" ").last

    begin
      decoded = JWT.decode(
        token,
        Rails.application.credentials.devise[:jwt_secret_key],
        true,
        { algorithm: "HS256" }
      )[0]

      # Assuming user id is stored in "sub" key of JWT payload
      user_id = decoded["sub"].to_i
      @current_user = User.find(user_id)

    rescue JWT::DecodeError
      render json: { error: "Invalid token" }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :unauthorized
    rescue JWT::ExpiredSignature
      render json: { error: "Token expired" }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
