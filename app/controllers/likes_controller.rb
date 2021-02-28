class LikesController < ApplicationController
  before_action :item_params
  
  def create
      @micropost = Micropost.find(params[:micropost_id])
      like = current_user.likes.new(user_id: current_user.id, micropost_id: @micropost.id)
      like.save
      #通知の作成
      @microost.create_notification_by(current_user)
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    like = Like.find_by(user_id: current_user.id, micropost_id: @micropost.id)
    like.destroy
  end

  private
  def item_params
    @micropost = Micropost.find(params[:micropost_id])
  end
end
