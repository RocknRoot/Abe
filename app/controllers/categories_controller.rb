class CategoriesController < ApplicationController
  before_filter :user_loggued, :categories

  def index
    @children_categories = @current_user.categories.all(:conditions => [ "parent_id IS NULL" ], :order => "name")
    @breadcrumb = t("categories.root").downcase
    @title = t("categories.root").downcase
    @child = Category.new
    @terms = @current_user.terms.all(:conditions => "category_id IS NULL", :order => "name")
    render "show"
  end

  def show
    @category = Category.find_by_id(params[:id])
    if @category.nil? or @category.user_id != @current_user.id
      redirect_to categories_path
    else
      @children_categories = @current_user.categories.all(:conditions => [ "parent_id = ?", params[:id] ], :order => "name")
      @child = Category.new
      @child.parent_id = @category.id
      @terms = Term.all(:conditions => [ "category_id = ?", @category.id ], :order => "name")
      generate_breadcrumb(@category)
      @title = "#{@category.name}"
    end
  end

  def create
    id = params[:category][:parent_id]
    if params[:category][:parent_id] != "" and @current_user.categories.find(params[:category][:parent_id]) == nil
      redirect_to categories_path
    else
      @category = Category.new
      @category.user_id = @current_user.id
      @category.name = params[:category][:name]
      @category.parent_id = params[:category][:parent_id] if params[:category].has_key?(:parent_id)
      if @category.save
        redirect_to(@category);
      else
        redirect_to category_path(@category.parent_id)
      end
    end
  end

  def edit
    @category = Category.find_by_id(params[:id])
    if @category.nil? or @category.user_id != @current_user.id
      redirect_to categories_path
    else
      generate_breadcrumb(@category)
      @title = "#{@category.name} . #{t("categories.edit")}"
    end
  end

  def update
    @category = Category.find_by_id(params[:id])
    if @category.nil? or @category.user_id != @current_user.id
      redirect_to categories_path
    else
      if @category.update_attributes(params[:category])
        redirect_to category_path(@category)
      else
        generate_breadcrumb(@category)
        @title = "#{@category.name} . #{t("categories.edit")}"
        render "edit"
      end
    end
  end

  def destroy
    @category = Category.find_by_id(params[:id])
    if @category.user_id != @current_user.id
      redirect_to categories_path
    else
      parent_id = @category.parent_id
      @category.destroy
      if parent_id
        redirect_to category_path(parent_id)
      else
        redirect_to categories_path
      end
    end
  end
end
