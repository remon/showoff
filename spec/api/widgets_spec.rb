require "rails_helper"

RSpec.describe "Widgets" do
  context "List and create widgets" do
    before(:all) do
      @user_params = {
        username: "mytestuser@showoff.ie",
        password: "123456789",
      }
      @showoff_user = ShowOff::Auth.new
      @user_data = @showoff_user.login(@user_params)

      @token = @user_data["data"]["token"]["access_token"]

      @random_name = "A Visible Widget #{rand(36 ** 5).to_s(36)}"

      @widget_params = {

        name: @random_name,
        description: "Widget 1",
        kind: "visible",
        token: @token,
      }
      @widget = Widget.new(@widget_params)
    end

    it "create a new widget(visible)" do
      @widget.save

      expect(@widget.user).not_to eq(nil)
    end
    it "can't create a widget with a duplicate name" do
      @widget2 = Widget.new(@widget_params)
      @widget2.save

      expect(@widget2.errors.full_messages[0]).to eq("Name has already been taken")
    end

    it "should list all widgets" do
      @showoff_widget = ShowOff::Widget.new(@token)
      @widgets = @showoff_widget.list
      expect(@widgets["data"]).not_to eq(nil)
    end

    it "should delete the created widget" do
      expect(@widget.destroy).to be_truthy
    end
  end
end
