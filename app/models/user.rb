class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorited_books, through: :fovorites, source: :book
  
  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id",dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",foreign_key: "followed_id",dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  # フォローユーザーは同一ではないか、なければ登録。other userはフォローされる人、  selfはメソドで今回はcurrent userとなる。
  def follow(other_user)
    unless self == other_user
      self.active_relationships.create(followed_id: other_user.id)
    end
  end
  # 二重のフォローの場合は登録を解除（もしrelationship内に除法がある場合）
  def unfollow(other_user)
     self.passive_relationships.find_by(followed_id: other_user.id).destroy
  end
  # フォローユーザー情報の取得と指定のユーザーが既にいないか確認
  def following?(other_user)
    following.include?(other_user)
  end

  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end
