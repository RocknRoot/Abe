class CategoriesController < ApplicationController
  before_filter :user_loggued, :categories

  def index
    @children_categories = @current_user.categories.all(:conditions => [ "parent_id IS NULL" ])
    @breadcrumb = t("categories.root")
    @child = Category.new
    render "show"
  end

  def show
    @category = Category.find_by_id(params[:id])
    if @category.nil? and !@current_user.categories.include?(@category)
      redirect_to categories_path
    else
      @children_categories = @current_user.categories.all(:conditions => [ "parent_id = ?", params[:id] ])
      @child = Category.new
      @child.parent_id = @category.id
      @breadcrumb = "#{@category.name}"
    end
  end

  def create
    if params[:category].has_key?(:parent_id) and @current_user.categories.all(:conditions => [ "id = ?", params[:category][:parent_id] ]).count == 0
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
  end

  def update
  end

  def destroy
    @category = Category.find_by_id(params[:id])
    if !@current_user.categories.include?(@category)
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

  private

  def categories
    @categories = @current_user.categories.all(:conditions => [ "parent_id IS NULL" ])
  end
end
