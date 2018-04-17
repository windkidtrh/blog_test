class RelationshipsController < ApplicationController
    before_action :current_user, only: [:create, :destroy]

    def create

        @user = User.find_by(id: params[:followed_id])

        if @current_user.nil? == false and @user.nil? == false
            #由于设置了多字段主键，所以失败会出错，
            #因此要先检验关系是否存在
            @relationship = Relationship.find_by(follower_id: @current_user[:id],
                                                 followed_id: params[:followed_id])

            if @relationship.nil?
                Relationship.new(follower_id: @current_user[:id],
                                 followed_id: params[:followed_id]).save
                render json: {message: "new a follower success"}
            else 
                render json: {message: "你已经关注此人"}
            end

        elsif @user.nil? == true
            render json: {message: "不存在该用户"}

        else
            render json: {message: "请输入正确token"}
        end
    end

    def destroy
        @user = User.find_by(id: params[:id])

        if @current_user.nil? == false and @user.nil? == false
            @relationship = Relationship.find_by(follower_id: @current_user[:id],
                                                 followed_id: params[:id])

            if @relationship.nil? == false
                @relationship.destroy

                render json: {message: "delete a follower success"}

            else 
                render json: {message: "你已经没有关注此人"}
            end

        elsif @user.nil? == true
            render json: {message: "不存在该用户"}

        else
            render json: {message: "请输入正确token"}
        end
    end

end
