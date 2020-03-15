class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @errors = nil

    @showoff_user = ShowOff::User.new
    response = @showoff_user.sign_up(params)
    respond_to do |format|
      if response["user"].nil?
        @errors = response["message"]
        format.js
      else
        format.html { redirect_to root_path }
      end
    end
  end
end
