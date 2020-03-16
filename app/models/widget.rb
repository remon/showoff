class Widget
  include ActiveModel::Model
  include ActiveModel::Serialization
  attr_accessor :name, :description, :kind, :token, :user_name
  validates :name, :description, :kind, presence: true
  validates :kind, inclusion: { in: %w(hidden visible) }, :allow_blank => true

  def attributes
    { name: "",
      description: "",
      kind: "" }
  end

  def save
    if valid?
      widget_params = {
        widget: self.serializable_hash,
      }

      @showoff_widget = ShowOff::Widget.new(token)
      response = @showoff_widget.make_widget(widget_params)
      if response["data"]
        self.user_name = response["data"]["widget"]["user"]["name"]
        return true
      end

      self.errors.add(:base, response["message"])
    end
    false
  end
end
