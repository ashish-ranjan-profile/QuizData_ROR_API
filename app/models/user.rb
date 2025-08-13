class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
has_many :quiz_histories, dependent: :destroy

   # Devise modules
   devise :database_authenticatable,
         :registerable,
            :recoverable,
         :jwt_authenticatable,
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
devise :omniauthable, omniauth_providers: [ :google_oauth2 ]
  # Ensure JTI is set before user is created
  before_create :set_jti


  private

  def set_jti
    self.jti ||= SecureRandom.uuid
  end

  def jwt_payload
    super
  end


def self.from_omniauth(auth)
  where(email: auth.info.email).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.name = auth.info.name # if you have a name column
    user.image = auth.info.image # if you have image column
  end
end
end
