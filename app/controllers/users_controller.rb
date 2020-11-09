class UsersController < ApplicationController

  def index
    if params[:name]
      @users = User.where(["name LIKE ?", "%#{params[:name]}%"]).page(params[:page]).per(20)
   else
     @users = User.all.order(name: :ASC).page(params[:page]).per(20)
   end
 end

  def show
    @user = User.find(params[:id])
  end


end
