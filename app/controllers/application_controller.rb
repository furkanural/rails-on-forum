class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :signed_in?, :current_user
  private
  def login(user)
  	session[:user_id] = user.id
  end
  
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def signed_in?
  	current_user
  end
  
  def validate_user!
    unless signed_in?
      redirect_to login_url, alert: 'Bu sayfaya erişmeden önce oturum açmalısınız.'
    end
  end

  def validate_permission!(user)
    unless current_user == user
      redirect_to root_url, alert: 'Bu işlemi gerçekleştiremezsiniz'
    end
  end

  def logout
    session[:user_id] = nil
  end

end
