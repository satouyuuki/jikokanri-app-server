class Api::AuthController < ApplicationController
  def sign_in
    user_object = {
      USERNAME: params[:username]
      PASSWORD: params[:password]
    }
    begin
      resp = CognitoService.authenticate(user_object).authentication_result
    rescue => exception
      resp = exception
    end
  end
  def sign_out
    if request.header['Authorization']
      CognitoService.sign_out(request.header['Authorization'])
      resp = {type: 'success', message: 'now you are disconected'}
    else
      resp = {type: 'error', message: 'empty token'}
    end
    render json: resp
  end
end
