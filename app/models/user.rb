class User < ActiveRecord::Base
  has_secure_password

  validates_uniqueness_of :name
  validates_uniqueness_of :email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true,
            case_sensitive: false
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_digest, presence: true, uniqueness: true

  has_many :photos, dependent: :destroy

  has_many :tags

  has_many :favorites

def recommend_photos
  recommends = []
  results = self.favorites #get self favorites
  photo_ids = []
  results.each do |result|
    photo_ids << result.photo_id
  end
  results.each do |result|
      photo_id = result.photo_id #get photo id of each favorite
      favorites = Favorite.where({ :photo_id => photo_id }) #get all favorites with that photo id
      favorites.each do |favorite|
        user_id = favorite.user_id #provide user id of each favorite
        other_user = User.where({:id => user_id }).first #find user with that id
        if other_user.id != self.id #only perform the following actions for users other than self
            other_user.favorites.each do |other_user_favorite| #find all the favorites of that user
               if !photo_ids.include?(other_user_favorite.photo.id) && other_user_favorite.photo.user_id != self.id#only put favorites into the recommends array if they are NOT photos self has favorited && also photos that self did NOT post
                  recommends << other_user_favorite.photo
              end
            end
          end
        end
   end
   no_duplicates = recommends.uniq #"uniq" is added to remove duplicates from the array
   no_duplicates
  end


end


