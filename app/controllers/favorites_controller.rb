class FavoritesController < ApplicationController

  def create
  favorite = current_user.favorites.create(startup_id: params[:startup_id])
  flash[:success] = "Thank you for promoting #{favorite.startup.name}"

  redirect_to startup_path(favorite.startup.id)
 end

 def destroy
  favorite = current_user.favorites.find_by(id: params[:id]).destroy
   flash[:success] = "Vous n'êtes plus contributeur de #{favorite.startup.name}"
 end
end
