class ProductionboxesController < ApplicationController
  # GET /productionboxes/1
  # GET /productionboxes/1.xml
  def show
    @box = Box.find(params[:id], :include => :punchlists, :order => 'punchlists.department_id')

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @box }
    end
  end

  # GET /productionboxes/1/edit
  def edit
    @box = Box.find(params[:id])
  end

  # PUT /productionboxes/1
  # PUT /productionboxes/1.xml
  def update
    @box = Box.find(params[:id])
    
    respond_to do |format|
      if @box.update_attributes(params[:box])
        format.html { redirect_to(@box.project, :notice => 'Module was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @box.errors, :status => :unprocessable_entity }
      end
    end
  end
end
