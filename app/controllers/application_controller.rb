class ApplicationController < ActionController::API
  before_action :current_user
  before_action :login_check
  before_action :set_res_header

  rescue_from Exception, with: :handle_error

  def login_check
    # tokenがあればtrue
    return @current_user&.token.present?
  end

  def current_user
    logger.info('application_controllerのcurrent_user')
    logger.info('application_controllerのAuthorization')
    logger.info(request.headers['Authorization'])
    logger.info('application_controllerのauthorization')
    logger.info(request.headers['authorization'])
    request_token = request.headers['Authorization']
    return unless request_token
    logger.info('request_token = ')
    logger.info(request_token)
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
    when ActiveRecord::RecordNotUnique then _render_400(exception)
    when ActionController::RoutingError then _render_404(exception)
    when ApplicationError then _render_app_err(exception)
    else _render_500(exception)
    end
  end
  # ログインしてないユーザが予期せぬURLを叩いた時
  def _render_500(error = nil)
    render json: {error: respond_error(error, TEST_ERROR_500)}, status: :internal_server_error
  end
  # データ不整合や意図しないエラー
  def _render_400(error = nil)
    render json: {error: respond_error(error, TEST_ERROR_400)}, status: :internal_server_error    
  end
  # ログインしてないユーザが予期せぬURLを叩いた時
  def _render_404(error = nil)
    render json: {error: respond_error(error, TEST_ERROR_404)}, status: :internal_server_error
  end
  # development環境はエラーコードを返却し、それ以外はコードを返す
  def respond_error(error, message)
    return error.message if error.present? && Rails.env.development?
    message
  end
  # コントロールされたアプリケーションエラーを返却する
  def _render_app_err(error)
    render json: {error: error.error}, status: :internal_server_error
  end
  def set_res_header
    # キャッシュを無効化する
    response.set_header('Cache-Control', 'no-cache')
  end
end
