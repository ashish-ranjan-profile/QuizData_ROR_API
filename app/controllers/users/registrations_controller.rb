class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private


  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :phone)
  end


def respond_with(resource, _options = {})
  if resource.persisted?
    sign_in(resource_name, resource)
    Rails.logger.info "TOKEN => #{request.env['warden-jwt_auth.token']}"
    token = request.env["warden-jwt_auth.token"]

    render json: {
      status: {
        code: 200,
        message: "Sign up successfully",
        token: token,
        data: resource
      }
    }, status: :ok
  else
    render json: {
      status: {
        code: 422,
        message: "User not created",
        errors: resource.errors.full_messages
      }
    }, status: :unprocessable_entity
  end
end
end
