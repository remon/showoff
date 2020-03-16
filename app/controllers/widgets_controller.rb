class WidgetsController < ApplicationController
  before_action :user_signed_in?
  #before_action :check_auth
  #TODO: set global before action to check cookies and authentication
  def index
    @token = JSON.parse(cookies[:showoff_user])["access_token"]
    @showoff_widgets = ShowOff::Widget.new
    @widgets = @showoff_widgets.list(@token)
  end
end
