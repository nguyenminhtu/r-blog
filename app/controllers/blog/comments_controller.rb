module Blog
  class CommentsController < ApplicationController
    before_action :authenticate_author!
    before_action :set_comment, only: [:destroy]

    def create
      @post = Post.find_by_friendly(params[:post_id])
      @comment = @post.comments.new(comment_params)
      @comment.author = current_author

      respond_to do |format|
          if @comment.save
            format.html { redirect_to post_path(@post), notice: "Thanks for post comment" }
          else
            format.html { redirect_to post_path(@post), alert: "Comment was unable to post !" }
          end
      end
    end

    def child_comment
      @post = Post.find_by_friendly(params[:post_id])
      @comment = @post.comments.new
      @comment.content = params[:content]
      @comment.author = current_author
      @comment.parent_id = params[:id]

      respond_to do |format|
        if @comment.save
          format.js
        else
          format.html { redirect_to post_path(@post), alert: "Comment was unable to post !" }
        end
      end
    end

    def destroy
      @children = Comment.where(parent_id: params[:id])
      respond_to do |format|
        if @comment.destroy
          if @children.count > 0
            @children.destroy_all
            format.js
          else
            format.js
          end
        else
          format.js
        end
      end
    end


    private

      def comment_params
        params.require(:comment).permit(:content)
      end

      def set_comment
        @comment = Comment.find(params[:id])
      end

  end
end
