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

    it "should not authenticate user with wrong data" do
      @user_params["username"] = "notvalidemail@showoff.ie"
      @user = @showoff_user.login(@user_params)

      expect(@user["data"]).to eq(nil)
    end
  end
end
