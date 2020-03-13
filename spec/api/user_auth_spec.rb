require "rails_helper"

RSpec.describe "User authentication" do
  context "validates user actions" do
    before(:all) do
      @user_params = {
        username: "mytestuser@showoff.ie",
        password: "123456789",
      }
      @showoff_user = ShowOff::Auth.new
    end

    it "should login the test user" do
      @user = @showoff_user.login(@user_params)
      expect(@user).not_to eq(nil)
    end

    it "should not authenticate user with wrong data" do
      @user_params["username"] = "notvalidemail@showoff.ie"
      @user = @showoff_user.login(@user_params)

      expect(@user).to eq(nil)
    end
  end
end
