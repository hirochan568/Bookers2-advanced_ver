class SearchesController < ApplicationController
  def search
    @range = params[:range]
    @favorite = Favorite.new
    if @range == "User"
      @users = User.looks(params[:searches], params[:words])
    else
      @books = Book.looks(params[:searches], params[:words])

    end
    @user = current_user
    @favorite = Favorite.new
  end
end
