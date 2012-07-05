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
    @user.encrypt_password;
    if @user.save
      redirect_to root_url, :notice => t("welcome.signed_up")
    else
      render "signup"
    end
  end

  def lost_password
    go_to_root_if_loggued
  end

  def lost_password_send
    go_to_root_if_loggued
    user = nil
    if params[:login] != ""
      user = User.find_by_login(params[:login])
    end
    if params[:email] != ""
      user = User.find_by_email(params[:email])
    end
    if user.nil?
      @error = t("welcome.lost_password_notfound")
      render "lost_password"
    else
      user.send_password_reset
      user.save
      UserMailer.password_reset(user).deliver
      redirect_to root_url, :notice => t("welcome.lost_password_sent")
    end
  end

  def lost_password_use
    if params[:token].nil?
      redirect_to root_url
    else
      @user = User.find_by_password_reset_token(params[:token])
      if @user.nil?
        redirect_to root_url
      end
    end
  end

  def lost_password_use_valid
    if params[:token].nil?
      redirect_to root_url
    else
      @user = User.find_by_password_reset_token(params[:token])
      if @user.nil?
        redirect_to root_url
      else
        if @user.password_reset_time > 2.hours.ago
          if params[:user][:password] and params[:user][:password_check] and params[:user][:password] == params[:user][:password_check]
            @user.password = params[:user][:password]
            @user.encrypt_password
            @user.password_reset_token = nil
            @user.password_reset_time = nil
            @user.save
            redirect_to root_url, :notice => t("welcome.lost_password_success")
          else
            render 'lost_password_use'
          end
        else
          redirect_to root_url
        end
      end
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
