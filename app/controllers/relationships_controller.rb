class RelationshipsController < ApplicationController
  def show
    @user = User.find(params[:id])
    @followers = @user.followers
    @following = @user.following
  end
  respond_to? :js
  def create
    if user_signed_in?
      @user = User.find(params[:relationship][:followed_id])
      current_user.follow!(@user)
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
  end
end
