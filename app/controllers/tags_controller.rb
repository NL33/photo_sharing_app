class TagsController < ApplicationController
  before_filter :authorize, only: [:new, :create, :edit, :update, :destroy]  #meaning must be logged in (per authorize method) to create, edit and update.
 
  def index 
    @tags = Tag.all
    @users = User.all
  end

  def new 
    @tag = Tag.new  #note: this line is likely not required
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = "tag added."
      redirect_to :back 
    else
      render 'new' 
    end
  end


 private

    def tag_params
      params.require(:tag).permit(:user_id, :photo_id)
    end

end