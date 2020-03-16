class Widget < OpenStruct
  def user_data
    UserData.new(user)
  end
end
