class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_user, :set_locale
  helper_method :current_user

  def user_loggued
    redirect_to welcome_path if !session[:user_id] and !@current_user
  end

  def go_to_explore_if_loggued
    redirect_to explore_path if session[:user_id]
  end

  def go_to_root_if_loggued
    redirect_to welcome_path if session[:user_id]
  end

  private

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def categories
    if @current_user
      @categories = @current_user.categories.all(:conditions => [ "parent_id IS NULL" ], :order => "name")
    end
  end

  def generate_breadcrumb(category)
    @breadcrumb = Array.new
    @breadcrumb << category
    @parent = category.parent
    while @parent
      @breadcrumb << @parent
      @parent = @parent.parent
    end
    @breadcrumb << t("categories.root").downcase
    @breadcrumb = @breadcrumb.reverse
  end
end
