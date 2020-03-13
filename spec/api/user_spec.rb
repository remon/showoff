require "rails_helper"

RSpec.describe "User" do
  context "create users" do
    before(:all) do
      random_username = (0...8).map { (65 + rand(26)).chr }.join
      @email = "#{random_username}@showoff.ie"
    end
    before(:each) do
      @showoff_user = ShowOff::User.new
      @user_params = {
        "first_name": "A",
        "last_name": "User",
        "image_url": "https://static.thenounproject.com/png/961-200.png",
      }
    end

    it "should check email availability " do
      expect(@showoff_user.check_email(@email)).to be_truthy
      ##if it fails , change the email address
    end
    it "should validates presence of email " do
      params = {
        user: @user_params,
      }
      response = @showoff_user.sign_up(params)

      expect(response["message"]).to eq("Email can't be blank")
    end
    it "should validates presence of password" do
      @user_params["email"] = @email
      params = {
        user: @user_params,
      }
      response = @showoff_user.sign_up(params)

      expect(response["message"]).to eq("Password can't be blank")
    end
    it "should validates length of password" do
      @user_params["email"] = @email
      @user_params["password"] = "123"
      params = {
        user: @user_params,

      }
      response = @showoff_user.sign_up(params)

      expect(response["message"]).to eq("Password is too short (minimum is 6 characters)")
    end
    it "should create a valid user" do
      @user_params["email"] = @email
      @user_params["password"] = "123456789"
      params = {
        user: @user_params,

      }
      response = @showoff_user.sign_up(params)

      expect(response["user"]).not_to eq(nil)
    end

    it "should validates email uniqueness " do
      @user_params["email"] = @email
      @user_params["password"] = "123456789"
      params = {
        user: @user_params,

      }

      response = @showoff_user.sign_up(params)

      expect(response["message"]).to eq("Email has already been taken")
    end
  end
end
