class Post < ActiveRecord::Base
  attr_accessible :id, :post_text, :user

  belongs_to :home
end
