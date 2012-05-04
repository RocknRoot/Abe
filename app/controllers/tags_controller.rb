class TagsController < ApplicationController
  before_filter :categories

  def index
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    if @tag.nil?
      redirect_to tags_path
    else
      if @current_user
        @terms = Term.tagged_with(@tag.name).all(:conditions => [ "user_id = ? OR public = ?", @current_user.id, true ])
      else
        @terms = Term.tagged_with(@tag.name).all(:conditions => [ "public = ?", true ])
      end
      @breadcrumb = "#{t("tags.tags")}"
      @title = @tag.name
    end
  end
end
