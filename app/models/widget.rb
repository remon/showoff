class Widget
  include ActiveModel::Model
  include ActiveModel::Serialization
  attr_accessor :id, :name, :description, :kind, :token, :user, :owner
  validates :name, :description, :kind, presence: true
  validates :kind, inclusion: { in: %w(hidden visible) }, :allow_blank => true

  def user_name
    UserData.new(user).name
  end

  def attributes
    { name: "",
      description: "",
      kind: "" }
  end

  def update_attributes(params)
    self.errors.clear
    @showoff_widget = ShowOff::Widget.new(token)
    response = @showoff_widget.update(id, params)

    if !response["data"].nil?
      self.attributes = params
      return true
    end

    self.errors.add(:base, "An Error While updating the widget")
    return false
  end

  def destroy
    @showoff_widget = ShowOff::Widget.new(token)
    response = @showoff_widget.delete(id)
    return true if !response["data"].nil?

    self.errors.add(:base, response["message"])
    return false
  end

  def save
    if valid?
      widget_params = {
        widget: self.serializable_hash,
      }

      @showoff_widget = ShowOff::Widget.new(token)
      response = @showoff_widget.make_widget(widget_params)
      if response["data"]
        self.user = response["data"]["widget"]["user"]
        self.id = response["data"]["widget"]["id"]
        self.owner = true
        return true
      end

      self.errors.add(:base, response["message"])
    end
    false
  end
end
