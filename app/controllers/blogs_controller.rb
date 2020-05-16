class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:index, :show]
  layout 'dashboard', only: [:my_posts]

  # GET /blogs
  # GET /blogs.json
  def index
    if params[:selected_topic].present?
      keys = []
      params[:selected_topic].each do |key, value|
        keys << key
      end
      @blogs = Blog.where(topic: keys)
    elsif params[:keyword].present?
      @blogs = Blog.where("LOWER(title) LIKE ? OR LOWER(topic) LIKE ?","%#{params[:keyword].downcase}%", "%#{params[:keyword].downcase}%")
    else
      @blogs = Blog.all
    end
    @top_posts = Blog.order(view_count: :desc).first(5)
    @users = User.last(12)
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    vc = @blog.view_count.to_i
    @blog.view_count = vc + 1
    @blog.save!
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my_posts
    @blogs = current_user.blogs
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @blog = Blog.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def blog_params
    params.require(:blog).permit(:title, :body, :user_id, :view_count, :topic)
  end
end
