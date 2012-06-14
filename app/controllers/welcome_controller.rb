class WelcomeController < ApplicationController
  before_filter :go_to_explore_if_loggued, :except => [:logout]

  def index
  end

  def signup
    go_to_root_if_loggued
    @user = User.new
  end

  def signup_create
    go_to_root_if_loggued
    @user = User.new(params[:user])
    @user.time_zone = "UTC"
    if @user.save
      redirect_to root_url, :notice => t("welcome.signed_up")
    else
      render "signup"
    end
  end

  def login
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to explore_path, :notice => t("welcome.loggued_in")
    else
      flash[:error] = t("welcome.invalid_login")
      render "index"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_url, :notice => t("welcome.loggued_out")
  end
end
