class WidgetsController < ApplicationController
  before_action :user_signed_in?

  def show
  end

  def new
    @widget = Widget.new
    respond_to do |format|
      format.js { render layout: false } # Add this line to you respond_to block
      format.html
    end
  end

  def create
    @widget = Widget.new(widget_params)
    respond_to do |format|
      if @widget.save
        format.js
      else
        format.js
      end
    end
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

  def destroy
    @widget = Widget.new(id: params[:id])
    @widget.token = JSON.parse(cookies[:showoff_user])["access_token"]

    @widget.destroy

    respond_to do |format|
      format.js
    end
  end

  private

  def widget_params
    token = JSON.parse(cookies[:showoff_user])["access_token"]
    params.require(:widget).permit(:name, :description, :kind).merge({ token: token })
  end
end
