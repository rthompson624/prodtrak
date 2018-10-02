class ReportsController < ApplicationController
  # GET /reports/departmentselector/1
  def departmentselector
    @project = Project.find(params[:id])
    @departments = Department.all
    
    respond_to do |format|
      format.html # departmentselector.html.erb
    end
  end

  # GET /reports/punchlistbydepartment/1/1
  def punchlistbydepartment
    @project = Project.find(params[:projectid])
    @department = Department.find(params[:departmentid])
    @punchlists = Punchlist.find(:all, :include => [{:box => :project}, :department], :conditions => ["punchlists.completed IS NULL AND projects.id = ? AND departments.id = ?", params[:projectid], params[:departmentid]], :order => "boxes.serial")
    
    respond_to do |format|
      format.html # punchlistbydepartment.html.erb
    end
  end

  # GET /reports/punchlist/1
  def punchlist
    @project = Project.find(params[:id])
    @boxes = Box.find(:all, :joins => :punchlists, :conditions => ["punchlists.completed IS NULL AND boxes.project_id = ?", params[:id]], :group => "boxes.serial", :order => "boxes.serial")
    @departments = Department.find(:all, :joins => {:punchlists => :box}, :conditions => ["punchlists.completed IS NULL AND boxes.project_id = ?", params[:id]], :group => "departments.id", :order => "departments.id")
    
    respond_to do |format|
      format.html # punchlist.html.erb
    end
  end

  # GET /reports/production/1
  def production
    @project = Project.find(params[:id], :include => :boxes)
    
    respond_to do |format|
      format.html # production.html.erb
    end
  end

end
