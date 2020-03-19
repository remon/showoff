require "rails_helper"

RSpec.describe "User Authentication" do
  context "validates user Login/LogOut/Refresh tokens" do
    before(:all) do
      @user_params = {
        username: "mytestuser@showoff.ie",
        password: "123456789",
      }
      @showoff_user = ShowOff::Auth.new
    end

    it "should login the test user" do
      @user = @showoff_user.login(@user_params)

      expect(@user["data"]).not_to eq(nil)
    end
    it "should send a reset password email" do
      params = {
        user: {
          email: @user_params[:username],
        },
      }

      @reset_password = @showoff_user.reset_password(params)
      expect(@reset_password["code"]).to eq(0)
    end

    it "shouldn't send a reset password if email is invalid" do
      params = {
        user: {
          email: "completewrongemail@showoff.ie",
        },
      }

      @reset_password = @showoff_user.reset_password(params)

      expect(@reset_password["code"]).to eq(3)
    end
    it "should not authenticate user with wrong data" do
      @user_params["username"] = "notvalidemail@showoff.ie"
      @user = @showoff_user.login(@user_params)

      expect(@user["data"]).to eq(nil)
    end
  end
end
