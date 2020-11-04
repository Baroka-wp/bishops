class StartupsController < ApplicationController
 before_action :authenticate_user!, only: %i[create new edit update destroy]
 before_action :set_startup, only: %i[show edit update destroy]
 before_action :login_check, only: %i[new edit destroy]
 before_action :user_check, only: %i[edit destroy]
 before_action :startup_check, only: %i[new create]



 def index

   @startups = Startup.where(["name LIKE ?", "%#{params[:name]}%"]) if params[:name]
   @startups = Startup.all.order(name: :ASC)
   @user = User.all
 end

 def new
   @user = User.all
   @startup = Startup.new
 end

 def create
   @startup = current_user.startups.build(startup_params)
   if @startup.save
     StartupMailer.startup_mail(@startup).deliver
     flash[:success] = 'startup successfully create'
     redirect_to user_path(current_user.id)
   else
     render :new
 end
end

 def show
   @favorite = @startup.favorites.find_by(startup_id: @startup.id)
 end

 def edit; end

 def update
   if @startup.update(startup_params)
     flash[:success] = 'startup successfully update !'
     redirect_to startup_path(@startup.id)
   else
     render :edit
   end
 end

 def destroy
   @startup.destroy
   flash[:success] = 'startup successfully destroy !'
   redirect_to startups_path
 end

 def terms; end

 private

 def startup_params
   params.require(:startup).permit(:name, :resume, :contact,
                                   :video,
                                   :trade_registre,
                                   :sector_of_business,
                                   :adresse,
                                   :banner, :banner_cache,
                                   :logo, :banner_cache)
 end

 def set_startup
   @startup = Startup.find(params[:id])
 end

 def user_check
   redirect_to startups_path, notice: 'access deny' unless current_user.id == @startup.user_id
 end


 def login_check
   unless user_signed_in?
     redirect_to new_user_registration_path, notice: 'you are not login, please login or create new accompt'
   end
 end

 def startup_check
   redirect_to startups_path, notice: 'you have a startup on Bishop' unless current_user.startups.empty?
 end

end
