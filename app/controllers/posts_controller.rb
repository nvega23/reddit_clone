class PostsController < ApplicationController
    before_action :require_logged_in

    def edit
        @subs = Sub.all
        @post = Post.find_by(id: params[:id])
        if @post
            render :edit
        end
    end

    def show
        @post = Post.find_by(id: params[:id])
        render :show
    end

    def update
        @post = Post.find_by(id: params[:id])
        if @post.author_id == current_user.id
            if @post.update(post_params)
                params[:post][:sub_id].each do |id|
                    PostSub.update(post_id: @post.id, sub_id: id)
                end
                redirect_to users_url
            else
                flash[:errors] = @post.errors.full_messages
                render :edit
            end
        else
            render :edit
        end
    end

    def new
        @subs = Sub.all
        @post = Post.new
        render :new
    end

    def create
        @post = Post.new(post_params)
        @post.url = "posts/" + @post.id.to_s
        if @post.save
            params[:post][:sub_id].each do |id|
                PostSub.create(post_id: @post.id, sub_id: id)
            end
            redirect_to post_url(@post.id)
        else
            flash[:errors] = @post.errors.full_messages
            render :new
        end
    end

    private
    def post_params
        params.require(:post).permit(:title, :content, :sub_id)
    end

end
