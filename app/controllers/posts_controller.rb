class PostsController < ApplicationController
  skip_before_filter :authorize, :only =>[:index,:show]
  skip_before_filter :authorizeAdmin
  # GET /posts
  # GET /posts.json


  def index
     @posts = Post.find(:all)
      @posts.each do |dec|
      dayDiff=Time.now.day - dec.created_at.day
      dec.weight = dec.votes-dayDiff
      dec.save
      end




    if params[:search] || params[:type]
      @posts = Post.search(params[:search], params[:type])
    else
      @posts = Post.all  :order => 'weight DESC'

    end






     respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
     end
     #end


      #@posts = Post.all :order => 'votes DESC'
     # @posts.each do |dec|
     # dayDiff=Time.now.day - dec.created_at.day
     # dec.weight = dec.votes-dayDiff
     # dec.save

    #end

  #end


    #@posts = Post.all :order => 'weight DESC'

    #respond_to do |format|
     # format.html # index.html.erb
     # format.json { render json: @posts }
    #end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit

    @post = Post.find(params[:id])
    if(@post.postUserID.to_s != session[:user_id].to_s)
      redirect_to @post, notice: 'You can not edit others post'
    else
      return
    #  @post = Post.find(params[:id])
    end
  end

  # POST /posts
  # POST /posts.json
  def create

    @post = Post.new(params[:post])
    @post.postUserID = session[:user_id]
    @post.votes = 0
    @post.weight = 100
    @post.posterName = session[:user_name]
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    if(@post.postUserID.to_s == session[:user_id].to_s || session[:user_aut].to_s=='1' )
      @post.destroy
      respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
      end
    else
      redirect_to @post, notice: 'You can not delete others post'


    end

  end





end
