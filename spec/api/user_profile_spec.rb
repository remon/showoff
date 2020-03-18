require "rails_helper"

RSpec.describe "User Profile" do
  context "Show User Profile" do
    before(:all) do
      @user_params = {
        username: "mytestuser@showoff.ie",
        password: "123456789",
      }
      @showoff_user = ShowOff::Auth.new
      @user_data = @showoff_user.login(@user_params)

      @token = @user_data["data"]["token"]["access_token"]
      @user = ShowOff::User.new()
      @user_profile = @user.show(198)
    end

    it "shouldn't show user profile without authentication" do

      ## no authentication (msg : Your session has expired. Please login again to continue.)
      expect(@user_profile["code"]).to eq(10)
    end
    it "shouldn return user data nil without authentication" do
      expect(@user_profile["data"]).to eq(nil)
    end
    it "shouldn't show user profile without authentication" do
      @own_profile = @user.profile
      expect(@own_profile["data"]).to eq(nil)
    end
    it "should return the user own profile with access token " do
      @user.set_token(@token)
      @own_profile = @user.profile
      expect(@own_profile["data"]["user"]).not_to eq(nil)
    end
    it "should show the user profile data with access token" do
      @user_profile = @user.show(198)
      expect(@user_profile["data"]["user"]).not_to eq(nil)
    end
    it "should show the user is not found with wrong id" do
      random_id = (0...10).map { (65 + rand(26)).chr }.join
      @user_profile = @user.show(random_id)
      # User is not found with wrong id (msg : That user does not exist)
      expect(@user_profile["code"]).to eq(3)
    end
  end
end
