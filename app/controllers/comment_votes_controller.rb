class CommentVotesController < ApplicationController
  skip_before_filter :authorizeAdmin, :only => [:new, :create, :show]
  # GET /comment_votes
  # GET /comment_votes.json
  def index
    @comment_votes = CommentVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comment_votes }
    end
  end

  # GET /comment_votes/1
  # GET /comment_votes/1.json
  def show
    @comment_vote = CommentVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment_vote }
    end
  end

  # GET /comment_votes/new
  # GET /comment_votes/new.json
  def new
    @comment_vote = CommentVote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment_vote }
    end
  end

  # GET /comment_votes/1/edit
  def edit
    @comment_vote = CommentVote.find(params[:id])
  end

  # POST /comment_votes
  # POST /comment_votes.json
  def create
    @post = Post.find(params[:postID])
    @comment = Comment.find(params[:commentID])
    if (@post.postUserID.to_s == session[:user_id].to_s )
      redirect_to  @post, notice: 'You can not vote the comments on your own post'
    elsif(@comment.commenterID.to_s == session[:user_id].to_s)
      redirect_to  @post, notice: 'You can not vote your own comment'
    elsif(@post.checkIfCommentVoted(session[:user_id].to_s,@post.id.to_s, @comment.id.to_s)[0]!=nil  )
      redirect_to  @post, notice: 'You have already voted for this post.'
    else

    @comment_vote = CommentVote.new(params[:comment_vote])
    @comment_vote.userID = session[:user_id]
    @comment_vote.postID = params[:postID]
    @comment_vote.commentID = @comment.id
    @comment.increment(:commentVotes)
    @comment.save

    respond_to do |format|
      if @comment_vote.save
        format.html { redirect_to @post, notice: 'Comment vote was successfully created.' }
        format.json { render json: @comment_vote, status: :created, location: @comment_vote }
      else
        format.html { render action: "new" }
        format.json { render json: @comment_vote.errors, status: :unprocessable_entity }
      end
      end
    end
  end

  # PUT /comment_votes/1
  # PUT /comment_votes/1.json
  def update
    @comment_vote = CommentVote.find(params[:id])

    respond_to do |format|
      if @comment_vote.update_attributes(params[:comment_vote])
        format.html { redirect_to @comment_vote, notice: 'Comment vote was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comment_votes/1
  # DELETE /comment_votes/1.json
  def destroy
    @comment_vote = CommentVote.find(params[:id])
    @comment_vote.destroy

    respond_to do |format|
      format.html { redirect_to comment_votes_url }
      format.json { head :ok }
    end
  end
end
