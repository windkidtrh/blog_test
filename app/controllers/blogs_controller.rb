class BlogsController < ApplicationController
    before_action :current_user, only: [:show, :create, :destroy]

    def show
        # @user = User.find(params[:id])
        @user = User.find(params[:id])
        if @user[:token] == @token
            @blogs = @user.blogs.all
            render json: @blogs
        else
            render json: {error: "请输入正确token"}
        end
    end

    def create
        #因为current_user本身就可能不合法了
        #所以这里用不了and条件执行.blogs.new操作
        #nil.blogs.new是不存在的
        if @current_user.nil? == false 
            @blog = @current_user.blogs.new(blog_create_params)

            if @blog.save
                render json: @blog

            else
                result = {}
                result["error_num"]      = @blog.errors.count
                result["error_messages"] = @blog.errors.full_messages
                render json: result
            end

        else
            render json: {message: "请输入正确token"}
        end
    end

    def destroy

        if @current_user.nil? == false
            @blogs  = @current_user.blogs.find_by(id: params[:id])
            if @blogs.nil? == false
                @blogs.destroy
                render json: {message: "delete_current_blog success"}
            else
                render json: {message: "当前用户的微博不存在"}
            end
        else
            render json: {message: "请输入正确token"}
        end
    end


    private 

        def blog_create_params
            params.permit(:content)
        end
end
