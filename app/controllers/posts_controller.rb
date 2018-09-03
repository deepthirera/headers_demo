class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create

    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html {redirect_to @post, notice: 'Post was successfully created.'}
        format.json {render :show, status: :created, location: @post}
      else
        format.html {render :new}
        format.json {render json: @post.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_votes
    @vote = Vote.find_or_initialize_by(post_id: vote_params[:post_id], user_id: current_user.id)

    respond_to do |format|
      if @vote.save
        format.html {redirect_to @vote, notice: 'vote was successfully created.'}
        format.json {render :show, status: :created, location: @vote}
      else
        format.html {render :new}
        format.json {render json: @vote.errors, status: :unprocessable_entity}
      end
    end
  end

  def up_vote
    puts vote_params
    @vote = Vote.find_or_initialize_by(post_id: vote_params[:post_id], user_id: current_user.id)

    respond_to do |format|
      if @vote.save
        format.html {redirect_to posts_url, notice: 'Upvoted'}
        format.json {render :show, status: :created, location: @vote}
      else
        format.html {render :new}
        format.json {render json: @vote.errors, status: :unprocessable_entity}
      end
    end
  end

  def down_vote
    @vote = Vote.find_or_initialize_by(post_id: vote_params[:post_id], user_id: current_user.id)

    @vote.destroy
    respond_to do |format|
      format.html {redirect_to posts_url, notice: 'Down voted'}
      format.json {render :show, status: :d, location: @vote}
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html {redirect_to posts_url, notice: 'Post was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :content)
  end

  def vote_params
    params.require(:vote).permit(:post_id)
  end
end
