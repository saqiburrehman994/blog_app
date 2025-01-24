class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]

  # GET /posts/:post_id/comments/new
  def new
    @comment = @post.comments.build
  end

  # POST /posts/:post_id/comments
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: "Comment added successfully."
    else
      redirect_to @post, alert: "Comment could not be added."
    end
  end

  # GET /posts/:post_id/comments/:id/edit
  def edit
    # @comment is already set by before_action
  end

  # PATCH/PUT /posts/:post_id/comments/:id
  def update
    if can? :update, @comment
        if @comment.update(comment_params)
          redirect_to @post, notice: "Comment updated successfully."
        else
          render :edit, status: :unprocessable_entity
        end
    else
      head :forbidden
    end
  end

  # DELETE /posts/:post_id/comments/:id
  def destroy
    if can? :destroy, @comment
      @comment.destroy
      redirect_to @post, notice: "Comment deleted successfully."
    else
      head :forbidden
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:post_id])
    return redirect_to posts_path, alert: "Post not found." unless @post
  end

  def set_comment
    @comment = @post.comments.find_by(id: params[:id])
    return redirect_to @post, alert: "Comment not found." unless @comment
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
