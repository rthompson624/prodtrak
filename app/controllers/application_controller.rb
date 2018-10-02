# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :perform_security_check
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def perform_security_check
    if (controller_name != "logins") && !hasValidSession
      respond_to do |format|
        format.html { redirect_to(new_login_path, :notice => 'You attempted to access the site without being logged in.  Please log in.') }
      end
    end
  end
    
  def hasValidSession
    # Check for session_hash cookie
    if cookies[:session_hash].nil?
      return false
    end
    
    # Lookup session and check if login date is within 24 hours
    lclSessions = Session.find_all_by_session_hash(cookies[:session_hash])
    if lclSessions.empty? || lclSessions.length > 1
      return false
    end
    if (lclSessions[0].login + 24.hours) < DateTime.now
      return false
    end
    
    # Set user
    @user = lclSessions[0].user
    return true
  end
  
  def getNewSessionHash
    return @user.first_name + DateTime.now.to_s
  end
  
end
