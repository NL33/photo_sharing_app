class PhotosController < ApplicationController
  before_filter :authorize, only: [:new, :create, :edit, :update, :destroy]  #meaning must be logged in (per authorize method) to create, edit and update.
 
  def index 
    @photos = Photo.all
    @users = User.all
  end

  def new 
    @photo = current_user.photos.build  #this method (and the photos.build in create) makes it so that whenever a user creates a photo, it is automatically added to their profile (even if hit "add photo" while viewing another's profile)
    @user = User.find(params[:user_id]) #another method would be to set this to current_user
    #as opposed to photos.build method, if wanted to make it so could only create photo from within your profile (eg, if viewing the show page of another user, could not create a photo yourself from that page), could use this that raises an error:
      #if @user != current_user  
      # flash[:notice] = "you are not authorized to do post a photo for that account."
       #redirect_to root_path 
    #end
  end

  def create
    @photo = current_user.photos.build(photo_params)
    @user = User.find(params[:user_id])#another method would be to set this to current_user
     if @photo.save
        flash[:notice] = "photo created."
        redirect_to root_path 
      else
        render 'new' 
      end
  end

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id]) 
    @tag = Tag.new
    @favorite = Favorite.new
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

    def photo_params
      params.require(:photo).permit(:description, :image, :user_id)
    end

end