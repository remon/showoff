class User
  include ActiveModel::Model
  include ActiveModel::Serialization
  attr_accessor :first_name, :last_name, :email, :password, :image_url, :token

  #custom model validations to reduce API calls
  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, :allow_blank => true
  validates :password, length: { minimum: 6 }, :allow_blank => true

  def attributes
    { first_name: "",
      last_name: "",
      email: "",
      password: "" }
  end

  def save
    if valid?
      user_params = {
        user: self.serializable_hash,
      }

      @showoff_user = ShowOff::User.new
      response = @showoff_user.sign_up(user_params)
      if response["user"]
        self.token = response["token"]
        return true
      else
        self.errors.add(:base, response["message"])
      end
    end
    false
  end
end
