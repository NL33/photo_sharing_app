class AddImageToPhotos < ActiveRecord::Migration
  change_table :photos do |t|
      t.attachment :image
    end
  end
