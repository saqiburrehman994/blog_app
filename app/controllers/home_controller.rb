class HomeController < ApplicationController
  def index
    if user_signed_in? && current_user.admin?
      redirect_to admin_dashboard_path
    elsif user_signed_in? && current_user.profile.nil?
      redirect_to new_profile_path
    elsif user_signed_in?
        redirect_to posts_path
    end
  end
end
