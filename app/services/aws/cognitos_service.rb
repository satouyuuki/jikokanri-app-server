# frozen_string_literal: true

class CognitoService
  class << self
    # create client instanse 
    COGNITO = Aws::CognitoIdentityProvider::Client.new(
      region: ENV["AWS_REGION"],
      credentials: Aws::Credentials.new(
        ENV["AWS_ACCESS_KEY_ID"],
        ENV["AWS_SECRET_ACCESS_KEY"]
      )
    )

    def authenticate(user_object)
      auth_object = {
        user_pool_id: ENV['AWS_COGNITO_POOL_ID'],
        client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
        auth_flow: 'ADMIN_NO_SRP_AUTH',
        auth_parameters: user_object
      }

      COGNITO.admin_initiate_auth(auth_object)
    end

    def sign_out(access_token)
      COGNITO.global_sign_out(access_token: access_token)
    end

    def create_user(user_object)
      auth_object = {
        client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
        username: user_object[:USERNAME],
        password: user_object[:PASSWORD]
      }
      COGNITO.sign_up(auth_object)
    end
  end
end