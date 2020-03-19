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

        name: @random_name,
        description: "Widget 1",
        kind: "visible",
        token: @token,
      }
      @widget = Widget.new(@widget_params)
    end
    it "should list all visible widgets (no authentication)" do
      #      @showoff_widget = ShowOff::Widget.new(@token)
      @widgets = @showoff_widget.list_visible

      expect(@widgets["data"]).not_to eq(nil)
    end
    it "should list all logged in user widgets" do
      # @showoff_widget = ShowOff::Widget.new(@token)
      @widgets = @showoff_widget.logged_in_user_widgets
      expect(@widgets["data"]).not_to eq(nil)
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

    it "should show the specific widget" do
      @widget_show = @showoff_widget.show(@widget.id)
      expect(@widget_show["data"]).not_to eq(nil)
    end

    it "shouldn't update the widget if name is blank" do
      widget_params = {
        name: "",

      }

      @widget.update_attributes(widget_params)

      expect(@widget.errors.full_messages[0]).to eq("An Error While updating the widget")
    end
    it "should update the widget name" do
      widget_params = {
        name: @widget.name + " new updated name ",

      }

      @widget.update_attributes(widget_params)

      expect(@widget.errors.count).to eq(0)
    end

    it "should delete the created widget" do
      expect(@widget.destroy).to be_truthy
    end
  end
end
