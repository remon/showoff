class UsersController < ApplicationController
  before_action :check_login, only: [:show, :me]
  before_action :get_token, only: [:show, :me]
  before_action :set_showoff_user, only: [:me, :show]

  def me
    @user_data = @showoff_user.profile
  end

  def show
    @user_data = @showoff_user.show(params[:id])

    if @user_data["data"]
      @user = User.new(@user_data["data"]["user"])
    elsif @user_data["code"] == 3
      @user_not_found = true
    else
      @need_login = true
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.js { render layout: false } # Add this line to you respond_to block
      format.html
    end
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        @token = @user.token
        user_data = {
          token: @token["access_token"],
          username: @user.email,
        }
        cookies[:showoff_user] = { value: user_data.to_json, :expires => Time.now + @token["expires_in"] }
        puts @token["expires_in"].to_s
        format.html { redirect_to root_path }
      else
        format.js
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
