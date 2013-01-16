class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :userID
      t.string :postID

      t.timestamps
    end
  end
end
