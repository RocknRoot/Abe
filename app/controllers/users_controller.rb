class UsersController < ApplicationController
  before_filter :categories

  def index
  end

  def show
    @user = User.find_by_slug(params[:id])
    if @user.nil?
      redirect_to users_path
    else
      @breadcrumb = [ @user ]
      @title = "#{@user.login}"
      @terms = @user.terms.all(:conditions => [ "public = ?", true ])
    end
  end

  def edit
    if @current_user.login != params[:id]
      redirect_to users_path
    else
      @breadcrumb = [ @current_user ]
      @title = "#{@current_user.login} . #{t("users.edit")}"
    end
  end

  def update
    if @current_user.login != params[:id]
      redirect_to users_path
    else
      if params[:user][:old_password] != ""
        if BCrypt::Engine.hash_secret(params[:user][:old_password], @current_user.salt) == @current_user.password
          params[:user].delete(:old_password)
          @current_user.password = params[:user][:password]
          @current_user.encrypt_password
          @current_user.time_zone = params[:user][:time_zone]
          @current_user.language = params[:user][:language]
          if @current_user.save
            redirect_to user_path(@current_user)
          else
            @breadcrumb = [ @current_user ]
            @title = "#{@current_user.login} . #{t("users.edit")}"
            render "edit"
          end
        else
          @breadcrumb = [ @current_user ]
          @title = "#{@current_user.login} . #{t("users.edit")}"
          @current_user.errors.add(:password, t("users.edit_wrong_old_pass"))
          render "edit"
        end
      else
        params[:user].delete(:old_password)
        params[:user].delete(:password)
        if @current_user.update_attributes(:time_zone => params[:user][:time_zone],
                                           :language => params[:user][:language])
          redirect_to user_path(@current_user)
        else
          @breadcrumb = [ @current_user ]
          @title = "#{@current_user.login} . #{t("users.edit")}"
          render "edit"
        end
      end
    end
  end

end
