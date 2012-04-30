class TermsController < ApplicationController
  before_filter :user_loggued, :categories

  def show
    @term = Term.find(params[:id])
    if @term.nil? and !@current_user.categories.include?(@term)
      redirect_to categories_path
    else
      @category = Category.find_by_id(@term.category_id)
      @breadcrumb = ""
      if @category != nil
        @breadcrumb = "#{@category.name} / "
      end
      @breadcrumb += "#{@term.name}"
    end
  end

  def create
    if params[:type] == ""
      redirect_to categories_path
    else
      if params.has_key?(:category_id) and params[:category_id] != "" and @current_user.categories.all(:conditions => [ "id = ?", params[:category_id] ]).count == 0
        redirect_to categories_path
      else
        @term = Term.factory(params[:type])
        if @term == nil
          redirect_to categories_path
        else
          @term.user_id = @current_user.id
          trad = "terms.#{params[:type]}"
          @term.name = "#{t(trad)}"
          if params[:category_id] != ""
            @term.category_id = params[:category_id]
          end
          if @term.save
            redirect_to edit_term_path(@term.id)
          else
            redirect_to category_path(params[:category_id])
          end
        end
      end
    end
  end

  def edit
    @term = Term.find(params[:id])
    if @term.nil? and !@current_user.categories.include?(@term)
      redirect_to categories_path
    else
      @category = Category.find_by_id(@term.category_id)
      @breadcrumb = ""
      if @category != nil
        @breadcrumb = "#{@category.name} / "
      end
      @breadcrumb += "#{@term.name} / #{t("terms.edit")}"
    end
  end

  def update
    @term = Term.find(params[:id])
    if @term.nil? and !@current_user.categories.include?(@term)
      redirect_to categories_path
    else
      if @term.update_attributes(params[@term.class.name.underscore])
        if @term.category_id == nil
          redirect_to categories_path
        else
          redirect_to term_path(@term)
        end
      else
        render "edit"
      end
    end
  end

  def destroy
  end

  private

  def categories
    @categories = @current_user.categories.all(:conditions => [ "parent_id IS NULL" ])
  end
end
