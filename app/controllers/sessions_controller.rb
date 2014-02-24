class SessionsController < ActionController::Base

  # POST /sessions
  def create
    login_info = Uas::User.login(params[:phone], params[:password])
    cookies[:auth_token] = { value: login_info.token, domain: Rails.configuration.auth_domain }
    redirect_to root_url
  rescue Uas::Error
    redirect_to root_url
  end

  # DELETE /session/:session_id
  def destroy
    cookies.delete(:auth_token, domain: Rails.configuration.auth_domain)
    redirect_to root_url
  end

end