class SessionsController < ApplicationController
  def reset_password
    respond_to do |format|
      format.js { render layout: false } # Add this line to you respond_to block
      format.html
    end
  end

  def send_reset_instructions
    @showoff_user = ShowOff::Auth.new
    @reset_password = @showoff_user.reset_password(params)
    @error_msg = @reset_password["message"] if @reset_password["code"].to_i == 3
  end

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
      @token = @user["data"]["token"]
      user_data = {
        token: @token["access_token"],
        username: user_params[:username],
      }
      cookies[:showoff_user] = { domain: URI(request.host), value: user_data.to_json, :expires => Time.now + @token["expires_in"] }
      redirect_to root_path
    end
  end

  def destroy
    cookies.delete :showoff_user, :domain => URI(request.host)

    redirect_to root_path
  end

  private

  def user_params
    params.permit(:username, :password)
  end
end
