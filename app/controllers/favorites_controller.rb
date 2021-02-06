class FavoritesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_book


    def create
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    redirect_back(fallback_location: root_path)
    end

    def destroy
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
    end

    private

    def set_book
      @book = Book.find(params[:book_id])
    end

end
