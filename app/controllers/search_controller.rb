class SearchController < ApplicationController
  before_filter :categories

  def index
    @breadcrumb = t("general.search")
    if params.has_key?("search")
      @title = params["search"]
    else
      @title = t("general.search")
    end
    # categories
    if @current_user
      @found_categories = @current_user.categories.all(:conditions => [ "name LIKE ?", "%#{params["search"]}%" ], :order => "name")
    end
    # tags
    @found_tags = ActsAsTaggableOn::Tag.all(:conditions => [ "name LIKE ?", "%#{params["search"]}%" ], :order => "name")
    # users
    if @current_user
      @found_users = User.all(:conditions => [ "login LIKE ? and id != ?", "%#{params["search"]}%", @current_user.id ] )
    else
      @found_users = User.all(:conditions => [ "login LIKE ?", "%#{params["search"]}%" ] )
    end
    # terms
    if @current_user
      @found_terms = Term.all(:conditions => [ "name LIKE ? AND (user_id = ? OR public = ?)", "%#{params["search"]}%", @current_user.id, true ], :order => "name")
    else
      @found_terms = Term.all(:conditions => [ "name LIKE ? AND public = ?", "%#{params["search"]}%", true ], :order => "name")
    end
  end
end
