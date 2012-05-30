class UsersController < ApplicationController
  before_filter :categories

  def index
  end

  def show
    @user = User.find(params[:id])
    if @user.nil?
      redirect_to users_path
    else
      @breadcrumb = [ @user ]
      @title = "#{@user.login}"
      @terms = @user.terms.all(:conditions => [ "public = ?", true ])
    end
  end

  def edit
    if @current_user.id != params[:id].to_i
      redirect_to users_path
    else
      @breadcrumb = [ @current_user ]
      @title = "#{@current_user.login} . #{t("users.edit")}"
    end
  end

  def update
    if @current_user.id != params[:id].to_i or params[:user].has_key?(:created_at) or params[:user].has_key?(:email) or params[:user].has_key?(:login) or params[:user].has_key?(:salt)
      redirect_to users_path
    else
      if params[:user][:old_password] != "" and BCrypt::Engine.hash_secret(params[:user][:old_password], @current_user.salt) == @current_user.password
        params[:user].delete(:old_password)
        if @current_user.update_attributes(params[:user])
          redirect_to user_path(@current_user)
        else
          @breadcrumb = [ @current_user ]
          @title = "#{@current_user.login} . #{t("users.edit")}"
          render "edit"
        end
      else
        @breadcrumb = [ @current_user ]
        @title = "#{@current_user.login} . #{t("users.edit")}"
        @user.errors << t("users.edit_wrong_old_pass")
        render "edit"
      end
    end
  end

end
