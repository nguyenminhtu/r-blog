module Authors

    class PostsController < ApplicationController
        before_action :set_post, only: [:show, :edit, :update, :destroy]
        before_action :authenticate_author!

        def index
            @posts = current_author.posts.get_all(params[:page])
        end

        def new
            @post = current_author.posts.new
        end

        def create
            @post = current_author.posts.new(post_params)

            respond_to do |format|
                if @post.save
                    format.html { redirect_to authors_posts_path, notice: "Post was created successfully !" }
                else
                    format.html { render 'new', alert: "Some error has occured !" }
                end
            end
        end

        def edit
        end

        def show
        end

        def update
            respond_to do |format|
                if @post.update(post_params)
                    format.html { redirect_to authors_post_path(@post), notice: "Post was updated successfully" }
                else
                    format.html { render 'edit', alert: "Post was unable to update" }
                end
            end
        end

        def destroy
            respond_to do |format|
                if @post.destroy
                    format.html { redirect_to authors_posts_path, notice: "Post was deleted successfully" }
                else
                    format.html { redirect_to authors_posts_path, alert: "Post was unable to destroy" }
                end
            end
        end


        private

            def set_post
                @post = current_author.posts.find_by_friendly(params[:id])
            end

            def post_params
                params.require(:post).permit(:title, :description, :body, :image)
            end

    end

end
