class Post < ActiveRecord::Base
  attr_accessible :id, :post_text, :user, :EMAIL, :SUBJECT, :FIRST_NAME, :LAST_NAME

  belongs_to :home
end
