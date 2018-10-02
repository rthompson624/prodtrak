# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def convertDateTimeToShortFormat(theDate)
    if theDate.nil?
      return theDate
    else
      return Time.parse(theDate.to_s()).strftime("%Y-%m-%d")
    end
  end
  
  def convertZeroToBlank(theNumber)
    if theNumber == 0
      return ""
    else
      return theNumber
    end
  end
  
end
