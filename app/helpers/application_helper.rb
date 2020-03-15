module ApplicationHelper
  def custom_errors_list(errors_list)
    return errors_list.map { |e| "<li> #{e} </li>" }.join.html_safe
  end
end
