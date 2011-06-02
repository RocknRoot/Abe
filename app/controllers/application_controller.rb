class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def user_loggued
    redirect_to new_session_path if session[:user_id].nil?
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
