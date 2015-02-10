class FavoritesController < ApplicationController
  before_filter :authorize, only: [:new, :create, :edit, :update, :destroy]  #meaning must be logged in (per authorize method) to create, edit and update.
 
  def index 
    @favorites = Favorite.all
    @users = User.all
  end

  def new 
    @favorite = Favorite.new #likely not required
  end

  def create
      @favorite = Favorite.new(favorite_params)
      if @favorite.save
       flash[:notice] = "favorite added."
        redirect_to :back 
       else
       redirect_to :back, notice: "you have already added this to your favorites"
      end
     
  end

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id]) 
  end

  def edit 
    @photo = Photo.find(params[:id])
  end

  def update 
    @photo = Photo.find(params[:id])
    @photo.update(photo_params)
    redirect_to root_path
  end

 def destroy 
    @photo = Photo.find(params[:id])
    @photo.destroy
     flash[:notice] = "photo Deleted"
    redirect_to photos_path
 end

 private

    def favorite_params
      params.require(:favorite).permit(:user_id, :photo_id)
    end

end