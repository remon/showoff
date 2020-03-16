class Widget < OpenStruct
  def user_data
    UserData.new(user)
  end

  def user_name
    user_data.name
  end
end
