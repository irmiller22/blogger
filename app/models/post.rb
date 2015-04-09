class Post < ActiveRecord::Base
  has_many :comments

  validates_presence_of :name, :content
end
