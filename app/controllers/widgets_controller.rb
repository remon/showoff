class WidgetsController < ApplicationController
  before_action :user_signed_in?

  def new
  end

  def create
  end

  def index
    unless @must_login
      @token = JSON.parse(cookies[:showoff_user])["access_token"]
      @showoff_widgets = ShowOff::Widget.new(@token)
      @widgets_data = @showoff_widgets.list

      if @widgets_data["data"].nil?
        @must_login = true
        #TODO : Reset Cookies

      else
        @widgets = @widgets_data["data"]["widgets"].map { |i| Widget.new(i) }
      end
    end
  end
end
