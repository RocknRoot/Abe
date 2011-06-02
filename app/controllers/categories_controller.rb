class CategoriesController < ApplicationController
  before_filter :user_loggued

  private
  def get_parents(id)
    ways = []
    while id.to_s != "0"
      category = Category.find(id)
      ways << { 'name' => category.name, 'id' => id }
      id = category.parent_id
    end
    ways << { 'name' => 'root', 'id' => 0 }
    return ways.reverse
  end
  
  public
  # GET /categories/1/list
  # GET /categories.xml
  def list
    @categories = Category.all(:conditions => {:parent_id => params[:id]})
    @terms = Term.all(:conditions => {:category_id => params[:id]})
    @parents = get_parents(params[:id])
    if params[:id].to_s != "0"
      @parent_id = Category.find(params[:id]).parent_id
    end

    respond_to do |format|
      format.html # list.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1/add
  # GET /categories/1/add.xml
  def add
    @category = Category.new
    @category.parent_id = params[:id]

    respond_to do |format|
      format.html # add.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to(list_category_path(@category), :notice => 'Category was successfully created.') }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to(list_category_path(@category), :notice => 'Category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.xml  { head :ok }
    end
  end 
end
