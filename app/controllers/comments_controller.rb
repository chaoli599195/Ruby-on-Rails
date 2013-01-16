class CommentsController < ApplicationController

  skip_before_filter :authorizeAdmin, :only => [:new, :create, :show, :destroy]
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    @comment.commentVotes = 0
    @comment.commenterID = session[:user_id]

    redirect_to post_path(@post)
    #respond_to do |format|
     @comment.save
      #  format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
       # format.json { render json: @comment, status: :created, location: @comment }
      #else
      #  format.html { render action: "new" }
      #  format.json { render json: @comment.errors, status: :unprocessable_entity }
      #end
    #end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
   @post = Post.find(params[:postID])
    @comment = @post.comments.find(params[:commentID])
   if(@comment.commenterID.to_s == session[:user_id].to_s)

    @comment.destroy
   @post.save

    redirect_to @post
   else
     redirect_to @post, notice: 'You can not delete others comment'
   end

  end
end
