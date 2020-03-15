class User
  include ActiveModel::Model
  attr_accessor :first_name, :last_name, :email, :password, :image_url
end
