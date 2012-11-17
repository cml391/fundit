class SessionsController < ApplicationController
  # GET '/login'
  #
  # Shows a login form
  def new
  end

  # POST '/login'
  #
  # Logs a user in, given their email and password.
  def create
    # Search for either a Organization or a Volunteer with the given email
    user = Organization.find_by_email(params[:email]) || Volunteer.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      # We found the user, and the password was correct. Log them in.
      session[:user_id] = user.id
      session[:user_type] = user.class.to_s
      redirect_after_login
    else
      # Couldn't find the email, or password was invalid. Send the user
      # back to the login page with an error message.
      flash.now.alert = "Invalid email or password"
      render 'new'
    end
  end

  # DELETE '/logout'
  #
  # Destroy's the user's session, including their login and cart.
  def destroy
    session[:user_id] = nil
    session[:user_type] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end
end
