class QaboxesController < ApplicationController
  # GET /qaboxes/1
  # GET /qaboxes/1.xml
  def show
    @box = Box.find(params[:id], :include => :punchlists, :order => 'punchlists.department_id')

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @box }
    end
  end

  # GET /qaboxes/1/edit
  def edit
    @box = Box.find(params[:id])
  end

  # GET /qaboxes/1/signoff
  def signoff
    @box = Box.find(params[:id], :include => :punchlists)
    punchComplete = true
    
    # Check that all punchlist items have been completed
    @box.punchlists.each do |punchlist|
      if punchlist.completed.nil?
        punchComplete = false
      end
    end
    
    if punchComplete
      @box.end_actual = Time.now
      @box.save
      redirect_to qabox_path(@box.id), :notice => 'Module was successfully signed-off on.'
    else
      redirect_to qabox_path(@box.id), :notice => 'Module sign-off unsuccessfull.  Open punchlist items exist.'
    end
  end

  # PUT /qaboxes/1
  # PUT /qaboxes/1.xml
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
