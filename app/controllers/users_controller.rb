class UsersController < ApplicationController
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
