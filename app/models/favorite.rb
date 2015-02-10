class Favorite < ActiveRecord::Base
validates_uniqueness_of :user_id, :scope => [:photo_id], :message => "You have already added this photo to favorites"  #this is so user can only add the same photo once to their favorite list (ie, no duplicates in favorite list) #Note I am not relying on this error message. Rather, error message is listed in the controller create action.
belongs_to :user
belongs_to :photo
end