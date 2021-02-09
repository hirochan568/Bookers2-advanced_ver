class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit, :destroy]

  # def search
  #   method = params[:search_method]
  #   word = params[:search_word]
  #   @posts = Post.search(method,word)
  # end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def following
      @user  = User.find(params[:user_id])
      @users = @user.followings
      render 'show_follow'
  end

  def followers
    @user  = User.find(params[:user_id])
    @users = @user.followers
    render 'show_follower'
  end
  
  

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "You have updated user successfully."
    else
      flash[:notice]
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
     @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to  user_path(current_user)
    end
  end

end
