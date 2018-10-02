class PunchlistsController < ApplicationController
  # GET /punchlists
  # GET /punchlists.xml
  def index
    @punchlists = Punchlist.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @punchlists }
    end
  end

  # GET /punchlists/1
  # GET /punchlists/1.xml
  def show
    @punchlist = Punchlist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @punchlist }
    end
  end

  # GET /punchlists/new
  # GET /punchlists/new.xml
  def new
    @punchlist = Punchlist.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @punchlist }
    end
  end

  # GET /punchlists/1/edit
  def edit
    @punchlist = Punchlist.find(params[:id])
  end

  # POST /punchlists
  # POST /punchlists.xml
  def create
    @punchlist = Punchlist.new(params[:punchlist])

    respond_to do |format|
      if @punchlist.save
        format.html { redirect_to(qabox_path(@punchlist.box.id), :notice => 'Punchlist item was successfully added.') }
        format.xml  { render :xml => @punchlist, :status => :created, :location => @punchlist }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @punchlist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /punchlists/1
  # PUT /punchlists/1.xml
  def update
    @punchlist = Punchlist.find(params[:id])

    respond_to do |format|
      if @punchlist.update_attributes(params[:punchlist])
        format.html { redirect_to(qabox_path(@punchlist.box.id), :notice => 'Punchlist item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @punchlist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /punchlists/1/signoff
  def signoff
    @punchlist = Punchlist.find(params[:id])
    @punchlist.completed = Time.now
    @punchlist.save
    redirect_to qabox_path(@punchlist.box.id)
  end

  # DELETE /punchlists/1
  # DELETE /punchlists/1.xml
  def destroy
    @punchlist = Punchlist.find(params[:id])
    @punchlist.destroy

    respond_to do |format|
      format.html { redirect_to(punchlists_url) }
      format.xml  { head :ok }
    end
  end
end
