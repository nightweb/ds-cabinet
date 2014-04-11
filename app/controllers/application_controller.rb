class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

protected

  # @return [Uas::User] currently logged in user
  def current_user
    token = request.cookies['auth_token']
    @current_user ||= User.find_by_token(token) if token
  end
  helper_method :current_user

  # Add this method to before_action to authenticate access with redirect.
  # @example before_action :authenticate, only: [:show]
  def authenticate
    redirect_to root_url if current_user.nil?
  end

  # Add this method to before_action to authenticate access with 401 response code
  # @example before_action :authenticate, only: [:new]
  def authenticate_with_response
    render nothing: true, status: 401 if current_user.nil?
  end
end
