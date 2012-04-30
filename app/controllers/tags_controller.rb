class TagsController < ApplicationController
  before_filter :user_loggued, :categories

  def index
  end

  def show
    @tag = Tag.find(params[:id])
    if @tag.nil?
      redirect_to tags_path
    else
      @terms = @tag.terms.all(:conditions => [ "user_id = ?", @current_user.id ])
      @breadcrumb = "#{t("model.tags.tag")} / #{@tag.name}"
    end
  end

  private

  def categories
    @categories = @current_user.categories.all(:conditions => [ "parent_id IS NULL" ])
  end
end
