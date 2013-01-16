class Comment < ActiveRecord::Base
  belongs_to :post

   validates :post_id, :presence => true
  validates :commenterID, :presence => true
  validates :body, :presence => true

  attr_accessible  :post_id, :body, :commenterID
end
