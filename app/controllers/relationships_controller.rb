class RelationshipsController < ApplicationController

    def create
    # relationship = Relationship.new(followed_id: params[:user_id], follower_id: current_user.id)
    # relationship.save
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to user
    end


    def destroy
      # ↓解除したい相手のユーザー

      user = User.find(params[:user_id])
      user.unfollow(params[:user_id])
      redirect_to user
    end



end