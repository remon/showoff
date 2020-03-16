class SessionsController < ApplicationController
  def new
    respond_to do |format|
      format.js { render layout: false } # Add this line to you respond_to block
      format.html
    end
  end

  def create
    @showoff_user = ShowOff::Auth.new
    @errors = nil

    @user = @showoff_user.login(user_params)
    if @user["data"].nil?
      @errors = @user["message"]
    else
    end
  end

  def destroy
  end

  private

  def user_params
    params.permit(:username, :password)
  end
end
