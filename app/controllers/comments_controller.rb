class CommentsController < ApplicationController
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    #投稿に紐づいたコメントを作成
    @comment = @micropost.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment_item = @comment.micropost
    if @comment.save
      #通知の作成
      @comment_item.create_notification_comment!(current_user, @comment.id)
      render :index
    end
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :index
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:content, :micropost_id, :user_id)
  end
  
 
  
end
