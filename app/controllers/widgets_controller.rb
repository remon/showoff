class WidgetsController < ApplicationController
  before_action :check_login
  before_action :get_token

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

  ####
  # List All widgets in two cases
  # if user logged in (shows all widgets with actions)
  # if user not logged in (shows all public widgets)
  ####
  def index
    @showoff_widgets = ShowOff::Widget.new(@access_token)
    @widgets_data = @showoff_widgets.list_visible(params[:term])

    @widgets = @widgets_data["data"]["widgets"].map { |i| Widget.new(i) }
  end

  def destroy
    @widget = Widget.new(id: params[:id])
    @widget.token = @access_token

    @widget.destroy

    respond_to do |format|
      format.js
    end
  end

  def mywidgets
    @showoff_widgets = ShowOff::Widget.new(@access_token)
    @widgets_data = @showoff_widgets.logged_in_user_widgets

    @widgets = @widgets_data["data"]["widgets"].map { |i| Widget.new(i) }
    ####
    # List Logged In User  widgets
    ####
  end

  private

  def widget_params
    params.require(:widget).permit(:name, :description, :kind).merge({ token: @access_token })
  end
end
