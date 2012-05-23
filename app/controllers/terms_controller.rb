class TermsController < ApplicationController
  before_filter :user_loggued, :except => :show
  before_filter :categories
  autocomplete :tag, :name, :full => true, :class_name => 'ActsAsTaggableOn::Tag'

  def show
    @term = Term.find(params[:id])
    if @term.nil? and !@current_user.terms.include?(@term) and !@term.public
      redirect_to categories_path
    else
      @category = Category.find_by_id(@term.category_id)
      if @category == nil
        @breadcrumb = t("categories.root")
      else
        generate_breadcrumb(@category)
      end
      if @current_user and @current_user.id == @term.user_id
        @title = ""
      else
        @title = "#{@term.user.login} # "
      end
      @title += "#{@term.name}"
    end
  end

  def create
    if params[:type] == ""
      redirect_to categories_path
    else
      if params.has_key?(:category_id) and params[:category_id] != "" and @current_user.categories.find(params[:category_id]) == nil
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
    if @term.nil? and !@current_user.terms.include?(@term)
      redirect_to categories_path
    else
      @category = Category.find_by_id(@term.category_id)
      if @category == nil
        @breadcrumb = t("categories.root")
      else
        generate_breadcrumb(@category)
      end
      @title = "#{@term.name} . #{t("terms.edit")}"
    end
  end

  def update
    @term = Term.find(params[:id])
    if @term.nil? and !@current_user.terms.include?(@term)
      redirect_to categories_path
    else
      if @term.update_attributes(params[@term.class.name.underscore])
        if @term.category_id == nil
          redirect_to categories_path
        else
          redirect_to term_path(@term)
        end
      else
        if @term.category == nil
          @breadcrumb = t("categories.root")
        else
          generate_breadcrumb(@term.category)
        end
        @title = "#{@term.name} . #{t("terms.edit")}"
        render "edit"
      end
    end
  end

  def toggle_public
    @term = Term.find(params[:term_id])
    if @term.nil? and !@current_user.terms.include?(@term)
      redirect_to categories_path
    else
      @term.public = !@term.public;
      @term.save
      redirect_to term_path(@term)
    end
  end

  def destroy
    @term = Term.find(params[:id])
    if @term.nil? and !@current_user.terms.include?(@term)
      redirect_to categories_path
    else
      category_id = @term.category_id
      @term.destroy
      redirect_to category_path(category_id)
    end
  end
end
