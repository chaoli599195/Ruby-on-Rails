class Post < ActiveRecord::Base


  validates :title, :presence => true
  validates :content, :presence => true

  attr_accessible  :title, :content, :posterName

  has_many :comments, :dependent => :destroy


  def voted votesNum,postId


    sql=ActiveRecord::Base.connection()
    sql.update('UPDATE POSTS SET votes='+votesNum+' WHERE id='+postId)

  end

  def checkIfVoted postID,userID

    sql=ActiveRecord::Base.connection()
    result = sql.execute('SELECT * FROM VOTES WHERE postID='+postID+' AND userID='+userID)

    #Array results = Post.find_by_sql('SELECT * FROM VOTES WHERE postID='+postID+' AND postUserID='+userID)


  end

  def checkIfCommentVoted userID,postID,commentID

    sql=ActiveRecord::Base.connection()
    result = sql.execute('SELECT * FROM COMMENT_VOTES WHERE userID = '+userID+' AND postID='+postID+' AND commentID='+commentID)

    #Array results = Post.find_by_sql('SELECT * FROM VOTES WHERE postID='+postID+' AND postUserID='+userID)


  end

   def self.search(search, t)
    if search || t
      if t == "user"
        find(:all, :conditions => ['posterName = ?', search],:order=> 'weight DESC')
      else
        find(:all, :conditions => ['content LIKE ?', "%#{search}%"],:order=> 'weight DESC')
      end
    else
      find(:all)
    end
  end


end
