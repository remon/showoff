class WidgetsController < ApplicationController
  before_action :check_login
  before_action :get_token
  before_action :set_showoff_widgets, only: [:index, :edit, :update, :mywidgets]

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

  def edit
    @widgets_data = @showoff_widgets.show(params[:id])
    if @widgets_data["data"] and @widgets_data["data"]["widget"]["owner"]
      @widget = Widget.new(@widgets_data["data"]["widget"])
    end
    respond_to do |format|
      format.js { render layout: false }
      format.html
    end
  end

  def update
    @widget = Widget.new(id: params[:id])
    @widget.token = @access_token
    respond_to do |format|
      if @widget.update_attributes(widget_params.except(:token).to_h)
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

  ####
  # List Logged In User  widgets
  ####
  def mywidgets
    @widgets_data = @showoff_widgets.logged_in_user_widgets(params[:term])
    if @widgets_data["data"].nil?
      @must_login = true
    else
      @widgets = @widgets_data["data"]["widgets"].map { |i| Widget.new(i) }
    end
  end

  private

  def set_showoff_widgets
    @showoff_widgets = ShowOff::Widget.new(@access_token)
  end

  def widget_params
    params.require(:widget).permit(:name, :description, :kind).merge({ token: @access_token })
  end
end
