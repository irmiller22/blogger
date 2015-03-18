class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post.comments.build(comment_params)
    if @post.save
      redirect_to @post, notice: "Comment successfully posted!"
    else
      render :'posts/show', notice: "Unable to save the comment."
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if @comment.destroy
      redirect_to @comment.post, notice: "Comment destroyed."
    else
      render :'posts/show', notice: "Could not be destroyed."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body)
  end
end
