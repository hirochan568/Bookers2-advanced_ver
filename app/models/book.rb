class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites
	has_many :favorited_users, through: :favorites, source: :user
	has_many :book_comments, dependent: :destroy
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}


  def self.looks(searches,words)
    if searches == "forward_match"
      @books = Book.where("title LIKE?","#{words}%")
    elsif searches== "backward_match"
      @books = Book.where("title LIKE?","%#{words}")
    elsif searches == "perfect_match"
      @books = Book.where("#{words}")
    elsif searches == "partial_match"
      @books = Book.where("title LIKE?","%#{words}%")
    else
      @books = Book.all
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end



end
