module ReportsHelper
  
  # Calculate completed modules
  def getModulesCompleted ayBoxes
    intCount = 0
    ayBoxes.each do |box|
      if !(box.end_actual.nil?)
        intCount = intCount + 1
      end
    end
    return intCount
  end
  
  # Calculate modules with punchlist
  def getModulesCompletedWithPunchlist ayBoxes
    intCount = 0
    ayBoxes.each do |box|
      if !(box.plant_discharge.nil?) and box.end_actual.nil?
        intCount = intCount + 1
      end
    end
    return intCount
  end
  
  # Calculate modules in process (in plant)
  def getModulesInProcess ayBoxes
    intCount = 0
    ayBoxes.each do |box|
      if !(box.start_actual.nil?) and box.plant_discharge.nil?
        intCount = intCount + 1
      end
    end
    return intCount
  end
  
  # Calculate modules remaining (to build)
  def getModulesRemaining project
    intStarted = getModulesCompleted(project.boxes) + getModulesCompletedWithPunchlist(project.boxes) + getModulesInProcess(project.boxes)
    return project.box_count - intStarted
  end
  
  # Generate module production data
  def getModuleProductionData project
    dtStart = getModuleProductionDataStartDate(project)
    dtEnd = getModuleProductionDataEndDate(project)
    
    # Loop through weeks making counts
    dtIntervalStart = dtStart
    dtIntervalEnd = dtStart + 1.weeks
    ayProductionData = Array.new
    while dtIntervalEnd <= dtEnd
      ayIntervalData = Array[dtIntervalStart, dtIntervalEnd]
      intStartProjected = 0
      intStartActual = 0
      intCompleteProjected = 0
      intCompleteActual = 0
      intCompleteWithPunchlist = 0
      # Loop through modules
      project.boxes.each do |box|
        # Check if module was projected to start
        if !box.start_projected.nil?
          if (box.start_projected >= dtIntervalStart && box.start_projected < dtIntervalEnd)
            intStartProjected += 1
          end
        end
        # Check if module actually started
        if !box.start_actual.nil?
          if (box.start_actual >= dtIntervalStart && box.start_actual < dtIntervalEnd)
            intStartActual += 1
          end
        end
        # Check if module was projected to be completed
        if !box.end_projected.nil?
          if (box.end_projected >= dtIntervalStart && box.end_projected < dtIntervalEnd)
            intCompleteProjected += 1
          end
        end
        # Check if module was completed
        if !box.end_actual.nil?
          if (box.end_actual >= dtIntervalStart && box.end_actual < dtIntervalEnd)
            intCompleteActual += 1
          end
        end
        # Check if module was completed but has a punchlist
        if !box.plant_discharge.nil?
          if (box.plant_discharge >= dtIntervalStart && box.plant_discharge < dtIntervalEnd) && box.end_actual.nil?
            intCompleteWithPunchlist += 1
          end
        end
      end
      # Populate data array
      ayIntervalData << intStartProjected << intStartActual << intCompleteProjected << intCompleteActual << intCompleteWithPunchlist
      ayProductionData << ayIntervalData
      # Increment week interval
      dtIntervalStart = dtIntervalEnd
      dtIntervalEnd = dtIntervalEnd + 1.weeks
    end
    
    return ayProductionData
  end

  # Calculate start date for report
  def getModuleProductionDataStartDate project
    # Figure out starting date
    dtStart = nil
    dtStartProjected = Box.find(:all, :conditions => ["boxes.project_id = ? AND boxes.start_projected IS NOT NULL", project.id], :order => "boxes.start_projected")[0].start_projected
    dtStartActual = Box.find(:all, :conditions => ["boxes.project_id = ? AND boxes.start_actual IS NOT NULL", project.id], :order => "boxes.start_actual")[0].start_actual
    if dtStartProjected < dtStartActual
      dtStart = dtStartProjected
    else
      dtStart = dtStartActual
    end
    # Force starting date to be a Monday at 12 AM
    if dtStart.wday == 0
      dtStart = dtStart - 6.days
    else
      dtStart = dtStart - (dtStart.wday - 1).days
    end
    dtStart = dtStart.at_beginning_of_day
  
    return dtStart
  end

  # Calculate end date for report
  def getModuleProductionDataEndDate project
    # Figure out end date
    dtEnd = nil
    dtEndProjected = Box.find(:all, :conditions => ["boxes.project_id = ? AND boxes.end_projected IS NOT NULL", project.id], :order => "boxes.end_projected DESC")[0].end_projected
    if !Box.find(:all, :conditions => ["boxes.project_id = ? AND boxes.end_actual IS NOT NULL", project.id], :order => "boxes.end_actual DESC")[0].nil?
      dtEndActual = Box.find(:all, :conditions => ["boxes.project_id = ? AND boxes.end_actual IS NOT NULL", project.id], :order => "boxes.end_actual DESC")[0].end_actual
    else
      dtEndActual = DateTime.now - 50.years
    end
    if !Box.find(:all, :conditions => ["boxes.project_id = ? AND boxes.plant_discharge IS NOT NULL", project.id], :order => "boxes.plant_discharge DESC")[0].nil?
      dtPlantDischarge = Box.find(:all, :conditions => ["boxes.project_id = ? AND boxes.plant_discharge IS NOT NULL", project.id], :order => "boxes.plant_discharge DESC")[0].plant_discharge
    else
      dtPlantDischarge = DateTime.now - 50.years
    end
    if dtEndProjected > dtEndActual
      if dtEndProjected > dtPlantDischarge
        dtEnd = dtEndProjected
      else
        dtEnd = dtPlantDischarge
      end
    else
      if dtEndActual > dtPlantDischarge
        dtEnd = dtEndActual
      else
        dtEnd = dtPlantDischarge
      end
    end
    # Force end date to be a Monday at 12 AM
    dtEnd = dtEnd - (dtEnd.wday - 1).days
    dtEnd = dtEnd.at_beginning_of_day + 1.weeks
    
    return dtEnd
  end
  
  # Total production data to date
  def getProductionTotalsToDate ayProductionData
    ayTotals = [0, 0, 0, 0, 0]
    dtToday = DateTime.now
    ayProductionData.each do |ayInterval|
      if ayInterval[0] <= dtToday
        ayTotals[0] += ayInterval[2]
        ayTotals[1] += ayInterval[3]
        ayTotals[2] += ayInterval[4]
        ayTotals[3] += ayInterval[5]
        ayTotals[4] += ayInterval[6]
      end
    end
    
    return ayTotals
  end
  
end



