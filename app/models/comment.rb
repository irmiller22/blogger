class Comment < ActiveRecord::Base
  belongs_to :post

  validates :title, :body, presence: true
end
