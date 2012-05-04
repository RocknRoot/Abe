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
        @terms = @tag.terms.all(:conditions => [ "user_id = ? OR public = ?", @current_user.id, true ])
      else
        @terms = Term.all(:conditions => [ "public = ?", true ])
      end
      @breadcrumb = "#{t("model.tags.tag")} / #{@tag.name}"
    end
  end
end
