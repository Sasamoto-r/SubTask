class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :right_holder,     only: :destroy
 
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 3)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  
  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user     # 更新に成功した場合を扱う。
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_url
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def postpage
     if logged_in?
      @user = current_user
      @micropost = current_user.microposts.build
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
     end
  end

  private

    def user_params
      params.require(:user).permit(:name, :user_name, :website,
                                   :self_introduction, :email, :number, :gender,
                                   :password,:password_confirmation)
    end
    
    
     # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def right_holder
      @user = User.find(params[:id])
      if !current_user.admin? &&  !current_user
        redirect_to(@user)
      end
    end
    
     # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end