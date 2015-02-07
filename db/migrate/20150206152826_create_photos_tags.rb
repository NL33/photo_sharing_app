class CreatePhotosTags < ActiveRecord::Migration
  def change
    create_table :photos_tags do |t|
      t.belongs_to :photo, index: true 
      t.belongs_to :tag, index: true
    end
  end
end
