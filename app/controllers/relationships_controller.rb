class RelationshipsController < ApplicationController

    def create
    # relationship = Relationship.new(followed_id: params[:user_id], follower_id: current_user.id)
    # relationship.save
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_back(fallback_location: root_path)
    end


    def destroy
      # ↓解除したい相手のユーザー


      current_user.unfollow(params[:user_id])
      redirect_back(fallback_location: root_path)
    end



end