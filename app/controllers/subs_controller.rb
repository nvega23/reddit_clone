class SubsController < ApplicationController
    before_action :require_logged_in
    def index
        @subs = Subs.all
        render :index
    end

    def create
        @sub = Subs.find_by(subs_params)
        @sub.moderator_id = current_user.id
        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash[:errors] = @sub.errors.full_messages
            redirect_to sub_url(@sub)
        end
    end

    def new
        @sub = Sub.new
        render :new
    end

    def edit
        @sub = Sub.find_by(id: params[:id])
        if @sub
            render :edit
        end
    end

    def show
        @sub = Sub.find_by(id: params[:id])
        render :show
    end

    def update
        @sub = Sub.find_by(id: params[:id])
        if @sub.moderator_id == current_user
            if @sub.update(subs_params)
                redirect_to users_url
            else
                flash[:errors] = @sub.errors.full_messages
            end
        end
    end

    private
    def subs_params
        params.require(:sub).permit(:title, :description)
    end
end
