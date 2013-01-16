class VotesController < ApplicationController
  skip_before_filter :authorizeAdmin, :only => [:new, :create, :show]
  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @votes }
    end
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
    @vote = Vote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vote }
    end
  end

  # GET /votes/new
  # GET /votes/new.json
  def new
    @vote = Vote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vote }
    end
  end

  # GET /votes/1/edit
  def edit
    @vote = Vote.find(params[:id])
  end

  # POST /votes
  # POST /votes.json
  def create
    @post = Post.find(params[:postID])
    if (@post.checkIfVoted(@post.id.to_s, session[:user_id].to_s)[0]!=nil  )
      redirect_to  @post, notice: 'You have already voted for this post.'
    elsif @post.postUserID.to_s == session[:user_id].to_s
      redirect_to  @post, notice: 'You can not vote for yourself'
    else
    @vote = Vote.new(params[:vote])
    @vote.postID = params[:postID]
    @vote.userID = session[:user_id]

     @post.increment(:votes)
    @post.save
    # @post.voted((@post.votes+1).to_s,@post.id.to_s)
    #@post.increment(votes)

    respond_to do |format|
      if @vote.save
        format.html { redirect_to @post, notice: 'Vote successfully.' }
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.html { render action: "new" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
      end
  end

  # PUT /votes/1
  # PUT /votes/1.json
  def update
    @vote = Vote.find(params[:id])

    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy



    @vote = Vote.find(params[:id])

    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url }
      format.json { head :ok }
    end
  end
end
