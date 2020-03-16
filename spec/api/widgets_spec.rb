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
    end

    it "create a new widget(visible)" do
      widget_params = {
        widget: {
          name: @random_name,
          description: "Widget 1",
          kind: "visible",
        },
      }

      @showoff_widget = ShowOff::Widget.new(@token)
      @widget = @showoff_widget.make_widget(widget_params)

      expect(@widget["data"]).not_to eq(nil)
    end
    it "create a new widget(visible)" do
      widget_params = {
        widget: {
          name: @random_name,
          description: "Widget 1",
          kind: "visible",
        },
      }

      @showoff_widget = ShowOff::Widget.new(@token)
      @widget = @showoff_widget.make_widget(widget_params)

      expect(@widget["message"]).to eq("Name has already been taken")
    end
  end
end
