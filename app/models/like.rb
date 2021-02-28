class Like < ApplicationRecord
  belongs_to :micropost
  belongs_to :user
  
  validates_uniqueness_of :micropost_id, scope: :user_id
  private
  
    def current_user
      if session[:user_id]
        @current_user ||= User.find_by(id: session[:user_id])
      end
    end
  
    def logged_in?
      !current_user.nil?
    end
  
 
end
