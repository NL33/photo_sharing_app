class FavoritesController < ApplicationController
  before_filter :authorize, only: [:new, :create ]  #meaning must be logged in (per authorize method) to create
 
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

 private

    def favorite_params
      params.require(:favorite).permit(:user_id, :photo_id)
    end

end