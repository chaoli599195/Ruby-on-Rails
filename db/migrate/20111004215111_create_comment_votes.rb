class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.string :userID
      t.string :postID
      t.string :commentID

      t.timestamps
    end
  end
end
