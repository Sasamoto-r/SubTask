class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  #バリデーション
  validates :content, presence: true
end
