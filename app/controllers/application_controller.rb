class ApplicationController < ActionController::API
  before_action :current_user
  before_action :login_check

  rescue_from Exception, with: :handle_error

  def login_check
    # tokenがあればtrue
    return @current_user&.token.present?
  end

  def current_user
    request_token = request.headers['Authorization']
    return unless request_token

    @current_user = User.find_by(token: request_token)
    User.current_user = @current_user
    @current_user
  end
  private
  def handle_error(exception)
    @exception = exception
    # スタックトレースを出力する
    logger.error(exception)

    case exception
    when ApplicationError then _render_app_err(exception)
    else _render_500(exception)
    end
  end
  # ルートエラー500
  def _render_500(error = nil)
    render json: {error: respond_error(error, TEST_ERROR_500)}, status: :internal_server_error
  end
  # コントロールされたアプリケーションエラーを返却する
  def _render_app_err(error)
    render json: {error: error.code, message: error.error}, status: :internal_server_error
  end
end
