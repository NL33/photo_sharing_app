class Tag < ActiveRecord::Base

belongs_to :user
belongs_to :photo

def show_photo
   id = self.photo_id
   photo = Photo.where({:id => id}).first
   photo
end


end
