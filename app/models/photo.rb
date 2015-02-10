class Photo < ActiveRecord::Base
   has_attached_file :image, :styles => { :large => "350x350!", :medium => "300x300#", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

   validates_attachment_content_type :image, :content_type => /\Aimage/ # Validate content type. Required by paperclip for security.
     
   validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/, /gif/] #gif allows gif to be added as image

   belongs_to :users
  
   has_many :tags

   has_many :favorites
end