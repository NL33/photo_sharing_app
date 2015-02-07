class TagsController < ApplicationController
  before_filter :authorize, only: [:new, :create, :edit, :update, :destroy]  #meaning must be logged in (per authorize method) to create, edit and update.
 
  def index 
    @tags = Tags.all
    @users = User.all
  end

  def new 
    @tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @stop.save
      flash[:notice] = "tag added."
      redirect_to root_path #replacing what would have been redirect_to (/stops)
    else
      render 'new' #replacing render('stops/new.html.erb')
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

    def tag_params
      params.require(:tag).permit(:user_id, :photo_id)
    end

end