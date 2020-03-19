class ApplicationController < ActionController::Base
  def user_signed_in?
    return true if cookies[:showoff_user].present?
    return false
  end

  helper_method :user_signed_in?

  def check_login
    @not_logged_in = true
    @not_logged_in = false if user_signed_in?
  end

  def get_token
    @access_token = nil
    @access_token = JSON.parse(cookies[:showoff_user])["token"] if user_signed_in?
  end

  def get_user_name
    JSON.parse(cookies[:showoff_user])["username"]
  end

  helper_method :get_user_name
end
