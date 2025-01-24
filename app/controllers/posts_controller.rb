class PostsController < ApplicationController
  def index
    @categories = Category.all

    if params[:category_id].present?
      @posts = Post.published.includes(:liked_by, :category).where(category_id: params[:category_id])
    else
      @posts = Post.published.includes(:liked_by, :category)
    end

    if params[:search_by_title] && params[:search_by_title]!=""
      @posts = @posts.published.includes(:liked_by, :category).where("title LIKE ?","%#{params[:search_by_title]}%")
    end

    @posts =  @posts.page(params[:page])
  end

  def new
    @post = Post.new
  end
  def create
    @post = current_user.posts.new(post_params)
      if @post.publish_at && @post.publish_at > Time.current
        @post.published = false
        message = "Post scheduled for #{@post.publish_at}"
      else
        message = "Post published successfully."
      end
      if @post.save
        flash[:notice] = message
        redirect_to posts_path
      else
        render :new, status: :unprocessable_entity
      end
  end
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
    @new_comment = Comment.new
  end
  def edit
    @post = Post.find(params[:id])
  end

  def update
     @post = Post.find(params[:id])
      if can? :update, @post
        if @post.update(post_params)
          redirect_to posts_path, notice: :"Post has been updated successfully."
        else
          render :edit, status: :unprocessable_entity
        end
      else
        head :forbidden
      end
  end

  def destroy
    @post = Post.find(params[:id])
    if can? :destroy, @post
        @post.destroy
        flash[:alert] = "Post has been deleted successfully."
        redirect_to posts_path, status: :see_other
    else
      head :forbidden
    end
  end
  private
  def post_params
    params.require(:post).permit(:title,:content,:image,:category_id,:publish_at,:published)
  end
end
