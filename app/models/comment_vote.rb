class CommentVote < ActiveRecord::Base

   attr_accessible  :postID, :commentID, :userID

end
