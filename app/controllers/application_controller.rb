class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  # include UsersHelper 

  private
    def current_user
      #这里要return false 不然会死循环
      @token = request.headers[:token]
      return false unless @current_user = User.find_by(token: @token)    
    end
end
