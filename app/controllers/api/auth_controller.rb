class Api::AuthController < ApplicationController
  skip_before_action :login_check
  
  def invitation
    user_object = {
      USERNAME: params[:username],
      PASSWORD: params[:password]
    }
    begin
      resp = CognitoService.invite_user_create(user_object)
    rescue => exception
      # resp = exception
      raise ApplicationError.new(error: exception) if exception
    end
    render json: resp
  end
  def sign_in
    user_object = {
      USERNAME: params[:username],
      PASSWORD: params[:password]
    }
    begin
      resp = CognitoService.authenticate(user_object).authentication_result
      User.transaction do
        @user = User.find_by(email: params[:username])
        @user.token = resp.access_token
        @user.save!
      end
      resp_data = {}
      resp_data[:access_token] = @user.token
      resp_data[:email] = @user.email
    rescue => exception
      raise ApplicationError.new(error: exception) if exception
    end
    render json: resp_data
  end
  def sign_out
    if request.headers['Authorization']
      CognitoService.sign_out(request.headers['Authorization'])
      resp = {type: 'success', message: 'now you are disconected'}
    else
      resp = {type: 'error', message: 'empty token'}
    end
    render json: resp
  end
end
