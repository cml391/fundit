class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :add_x_frame_options_header

  # Returns the currently logged in user
  def current_user
    return @current_user if @current_user

    return nil unless (session[:user_id] and session[:user_type])

    return @current_user = session[:user_type].constantize.find_by_id(session[:user_id])
  end
  helper_method :current_user

  # call this after logging in a user in to redirect them to the page that
  # required login.
  def redirect_after_login
  	if current_user.kind_of? Volunteer
    	redir_target = session[:return_to] || volunteer_path(current_user)
    else
    	redir_target = session[:return_to] || organization_path(current_user)
    end
    session[:return_to] = nil
    redirect_to redir_target, :notice => "Welcome, #{current_user.name}"
  end

  private

  # Redirects to root_url unless the user is logged in.
  def require_user
    unless current_user
      session[:return_to] = request.fullpath
      redirect_to login_url, :alert => "You must be logged in to do that."
    end
  end

  # Redirects to root_url unless the current user is a Orgnaization.
  def require_organization
    unless current_user.kind_of? Organization
      redirect_to root_url, :alert => "You must be an organization to do that."
    end
  end

  # Redirects to root_url unless the current user is a Volunteer.
  def require_volunteer
    unless current_user.kind_of? Volunteer
      redirect_to root_url, :alert => "You must be a volunteer to do that."
    end
  end

  def add_x_frame_options_header
    response.headers['X-Frame-Options'] = 'SAMEORIGIN'
  end
end
