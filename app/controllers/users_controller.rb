class UsersController < ApplicationController
  before_action :current_user, only: [:feed, :feeder, :logout, :update, :destroy]
  def new
    #页面才需要操作，接口不用
    if @user = User.new
      render json: {message: "success"}
    end

  end

  def index
    if @users = User.all
      render json: @users
    end
  end

  #显示某个关注人的微博
  def feeder
    @user = User.find(params[:id])
    
    if @current_user.nil? == false
      @relationship = Relationship.find_by(follower_id: @current_user[:id],
                                             followed_id: @user[:id])
      if @relationship.nil? ==false
          @blogs = Blog.where(user_id: @user[:id])
          render json: @blogs

      else 
          render json: {message: "你已经没有关注此人"}
      end
    else
        render json: {message: "请输入正确token"}
    end
  end

  #显示所有关注人的微博
  def feed
    following_ids = "SELECT followed_id FROM relationships
                      WHERE  follower_id = :user_id"
    
    if @current_user.nil? == false
        @blogs = Blog.where("user_id IN (#{following_ids}) ", 
                              user_id: @current_user[:id])

        render json: @blogs
    else
        render json: {message: "请输入正确token"}
    end
  end

  #显示当前用户关注的所有人，这里我没有用token
  def following
    @user = User.find(params[:id])
    #following在user.rb中拥有has_many关系
    #following实则是一个虚拟的数据表，所以可以使用sql操作
    #来自active_relationships这个主动关系
    #该主动关系里面有follower_id,followed_id
    @users = @user.following.all
    render json: @users
  end

  #显示当前用户被关注的所有人
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.all
    render json: @users
  end

  def show
    #使用 params 获取用户的 ID。
    #当我们向 Users 控制器发送请求时，params[:id] 会返回用
    #户的 ID，即 1，所以这就和直接调用 User.find(1) 的效果一样
    if @user = User.find(params[:id])
      render json: @user
    end
  end

  def create
    @user = User.new(user_create_params) #健壮参数
    # 处理注册成功的情况
    if @user.save
      render json: @user
    else
      result = {}
      result["error_num"]      = @user.errors.count
      result["error_messages"] = @user.errors.full_messages
      render json: result
    end
  end

  def update
    @user  = User.find(params[:id])

    # 处理更新成功的情况
    if @user[:token] == @token and @user.update_attributes(user_update_params)
      render json: @user
    # 处理token值空或者错误的情况
    elsif @user[:token] != @token
      render json: {error: "请输入正确token"}
    # 处理token正确，但是参数错误的情况
    else
      result = {}
      result["error_num"]      = @user.errors.count
      result["error_messages"] = @user.errors.full_messages
      render json: result
    end
  end
  
  def destroy
    @user  = User.find(params[:id])

    if @current_user.nil? == false and @current_user[:admin] == true
       @user.destroy
       render json: {message: "delete_current_user success"}

    elsif @current_user.nil?
       render json: {error: "请输入正确token"}

    else
       render json: {error: "操作失败，你不是管理员"}
    end
  
  end

  def login
    @user = User.find_by(email: params[:email])
    # if @user && @user.try(:authenticate,params[:password])
    if @user && @user.authenticate(params[:password])
       @user.regenerate_token
       render json: @user, with_token: true
    else
       render json: {message: "账号密码错误"}
    end

  end

  def logout
    if @current_user
      # @user.regenerate_token
      render json: {message: "logout success"}
    else 
      render json: {error: "请输入正确token"}
    end
  end

  private
    def user_create_params
      #这里只允许传入4个参数
      params.permit(:name, :email, :password,
                                   :password_confirmation)
      #加上require(:user)后参数变成user[name]
      # params.require(:user).permit(:name, :email, :password,
      #                              :password_confirmation)
    end

    def user_update_params
      #这里只允许传入3个参数
      params.permit(:name, :password,
                           :password_confirmation)
    end


end
