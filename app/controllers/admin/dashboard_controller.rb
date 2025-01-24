class Admin::DashboardController < ApplicationController
  before_action :check_admin

  def index
    @posts = Post.all
    @comments = Comment.all
    @users = User.where(admin: false)
  end

  private

  def check_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to view this page."
    end
  end
end
