module Blog

    class PostsController < ApplicationController

        def index
            @posts = Post.get_all(params[:page], 9)
        end

        def show
            @post = Post.find_by_friendly(params[:id])
            @comments = @post.comments.where(parent_id: nil).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
            @comment = @post.comments.new
        end

    end

end
