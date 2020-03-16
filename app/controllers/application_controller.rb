class ApplicationController < ActionController::Base
  def user_signed_in?
    @must_login = false
    return true if cookies[:showoff_user]
    @must_login = true
    return false
  end

  helper_method :user_signed_in?
end
