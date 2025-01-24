class ProfilesController < ApplicationController
  before_action  :set_profile, only: [:edit, :update]

  def new
    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to posts_path, notice: "Profile created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to posts_path, notice: "Profile updated successfully."
    else
      render :edit
    end
  end

  private
  def set_profile
    @profile = current_user.profile
  end
  def profile_params
    params.require(:profile).permit(:name,:birth_date,:gender,:avator)
  end
end
