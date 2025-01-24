module ApplicationHelper
  def user_name(user)
    user.email.split('@').first.capitalize
  end
end
