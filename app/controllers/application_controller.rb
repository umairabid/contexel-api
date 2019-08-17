class ApplicationController < ActionController::API

  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::ActiveRecord::RecordNotUnique , with: :bad_request
  rescue_from ::NameError, with: :error_occurred
  rescue_from ::ActionController::RoutingError, with: :error_occurred
  rescue_from ::RuntimeError, with: :error_occurred
  rescue_from ::CanCan::AccessDenied, with: :auth_error

  def current_user
    auth_token = request.headers['Auth-Token']
    @current_user ||= User.find_by_access_token auth_token
  end

  protected

  def record_not_found(exception)
    render json: {error: exception.message}.to_json, status: 404
  end

  def error_occurred(exception)
    render json: {error: exception.message}.to_json, status: 500
  end

  def bad_request(exception)
    render json: {error: exception.message}.to_json, status: 400
  end

  def auth_error(exception)
    render json: {error: exception.message}.to_json, status: 400
  end

end
