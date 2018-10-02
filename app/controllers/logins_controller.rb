class LoginsController < ApplicationController

  # GET /logins/new
  def new
    respond_to do |format|
      if hasValidSession
        format.html { redirect_to(projects_url) }
      else
        @user = User.new
        format.html # new.html.erb
      end
    end
  end

  # POST /logins
  def create
    # Lookup user
    @user = User.new(params[:user])
    ayUsers = User.find(:all, :conditions=>["user = ? AND password = ?", @user.user, @user.password])
    respond_to do |format|
      if ayUsers.empty?
        # User not found
        format.html { redirect_to("/logins/new", :notice => 'Invalid login.  Either the User or Password (or both) were incorrect.  Please try again or contact your system administrator.') }
        #format.html { render :action => "new" }
      else
        # Set user and create session
        @user = ayUsers[0]
        @session = Session.new
        @session.user_id = @user.id
        @session.session_hash = getNewSessionHash
        @session.login = DateTime.now
        @session.save
        cookies[:session_hash] = @session.session_hash
        format.html { redirect_to(projects_url) }
      end
    end
  end
  
end
