class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def show
    @micropost = Micropost.find(params[:id])
    @comment = Comment.new
    #新着順で表示
    @comments = @micropost.comments.order(created_at: :desc)
  end
  
  def create
    @micropost = current_user.microposts.build(micropost_params) 
    #@micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to micropost_path(@micropost.id)
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'users/postpage'
    end
  end
  

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @posts = Micropost.search(params[:search])
  end
  
  private

    def micropost_params
      params.require(:micropost).permit(:content, :img)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end