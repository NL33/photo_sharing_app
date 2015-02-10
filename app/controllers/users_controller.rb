class UsersController < ApplicationController
  
  def index
    @users = User.all
    user_id = session[:user_id] 
    @user = User.where({:id => user_id}).first
  end

  def new
	@user = User.new
  end

  def create
   @user = User.new(user_params)
   if @user.save
	   session[:user_id] = @user.id  #this is to log in the user automatically on signup by setting the user id session variable to that user’s id.
	   redirect_to root_url, notice: "Thank you for signing up!"
   else
	   render "new"
	 end
  end
 
  def show
    @user = User.find(params[:id])
    @favorites = Favorite.where(:user_id => @user.id)
  end

  def edit 
    @user = User.find(params[:id])
  end

  def update 
    @user = User.find(params[:id])
    @user.update(photo_params)
    redirect_to root_path
  end

 def destroy 
    @user = User.find(params[:id])
    @user.destroy
     flash[:notice] = "User Deleted"
    redirect_to root_path
 end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
