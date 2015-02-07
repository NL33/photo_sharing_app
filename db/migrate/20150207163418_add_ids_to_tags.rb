class AddIdsToTags < ActiveRecord::Migration
  def change
    add_column :tags, :user_id, :integer
    add_column :tags, :photo_id, :integer
  end
end
