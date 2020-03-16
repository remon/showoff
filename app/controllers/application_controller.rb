class ApplicationController < ActionController::Base
  def user_signed_in?
    return true if cookies[:showoff_user]

    return false
  end

  helper_method :user_signed_in?
end
