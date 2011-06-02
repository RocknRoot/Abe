class TermsController < ApplicationController
  before_filter :user_loggued

  # GET /terms/1/add
  # GET /terms/1/add.xml
  def add
    @term = Term.new
    @term.category = Category.find(params[:id])

    respond_to do |format|
      format.html # add.html.erb
      format.xml  { render :xml => @term }
    end
  end

  # GET /terms/1/edit
  def edit
    @term = Term.find(params[:id])
  end

  # POST /terms
  # POST /terms.xml
  def create
    @term = Term.new(params[:term])

    respond_to do |format|
      if @term.save
        format.html { redirect_to(list_category_path(@term.category_id), :notice => 'Term was successfully created.') }
        format.xml  { render :xml => @term, :status => :created, :location => @term }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @term.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /terms/1 
  # PUT /terms/1.xml
  def update 
    @term = Term.find(params[:id])

    respond_to do |format|
      if @term.update_attributes(params[:term])
        format.html { redirect_to(list_category_path(@term[:category_id]), :notice => 'Term was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @term.errors, :status => :unprocessable_entity }
      end 
    end  
  end

  # DELETE /terms/1
  # DELETE /terms/1.xml
  def destroy
    @term = Term.find(params[:id])
    @term.destroy

    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.xml  { head :ok }
    end
  end
end
