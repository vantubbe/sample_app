include SessionsHelper

class UserPostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  #before_action :set_user_post, only: [:show, :show_users_posts ,:edit, :update, :destroy]

  # GET /user_posts
  # GET /user_posts.json
  def index
    @user_posts = UserPost.all
  end

  def show
  end

  def show_users_posts
    @user_posts = UserPost.where(user_id: params[:id])
  end

  # GET /user_posts/new
  def new
    @user_post = UserPost.new
  end

  # GET /user_posts/1/edit
  def edit
  end

  # POST /user_posts
  # POST /user_posts.json
  def create
    @user_post = current_user.user_posts.build(user_post_params)
    
    if @user_post.save
      flash[:success] = "User post was successfully created."
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  # PATCH/PUT /user_posts/1
  # PATCH/PUT /user_posts/1.json
  def update
    respond_to do |format|
      if @user_post.update(user_post_params)
        format.html { redirect_to @user_post, notice: 'User post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_posts/1
  # DELETE /user_posts/1.json
  def destroy
    @user_post.destroy
    redirect_to root_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_post
      @user_post = UserPost.find(params[:id])
    end

    def correct_user
      @user_post = current_user.user_posts.find_by(id: params[:id])
      redirect_to root_url if @user_post.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_post_params
      params.require(:user_post).permit(:message)
    end
end
