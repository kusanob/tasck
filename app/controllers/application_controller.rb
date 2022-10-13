class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def forbid_login_user
    @current_user = User.find_by(id: session[:user_id])
    if @current_user
       flash[:danger] = 'ログインしてるよっ！！'
       redirect_to user_url(id: current_user)
    end
  end
  
end