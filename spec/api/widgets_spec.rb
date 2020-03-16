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
      @showoff_widget = ShowOff::Widget.new(@token)
      @random_name = "A Visible Widget #{rand(36 ** 5).to_s(36)}"

      @widget_params = {
        widget: {
          name: @random_name,
          description: "Widget 1",
          kind: "visible",
        },
      }
    end

    it "create a new widget(visible)" do
      @widget = @showoff_widget.make_widget(@widget_params)

      expect(@widget["data"]).not_to eq(nil)
    end
    it "can't create a widget with a duplicate name" do
      @widget = @showoff_widget.make_widget(@widget_params)

      expect(@widget["message"]).to eq("Name has already been taken")
    end

    it "should list all widgets" do
      @widgets = @showoff_widget.list
      expect(@widgets["data"]).not_to eq(nil)
    end
  end
end
