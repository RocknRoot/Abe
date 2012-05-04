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
      @found_categories = @current_user.categories.all(:conditions => [ "name LIKE ?", "%#{params["search"]}%" ])
    end
    # tags
    @found_tags = ActsAsTaggableOn::Tag.all(:conditions => [ "name LIKE ?", "%#{params["search"]}%" ])
    # terms
    if @current_user
      @found_terms = Term.all(:conditions => [ "name LIKE ? AND (user_id = ? OR public = ?)", "%#{params["search"]}%", @current_user.id, true ])
    else
      @found_terms = Term.all(:conditions => [ "name LIKE ? AND public = ?", "%#{params["search"]}%", true ])
    end
  end
end
