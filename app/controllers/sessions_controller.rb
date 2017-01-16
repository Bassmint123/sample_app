class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user   # user logs in 
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)  # Checking the remember me checkbox
      redirect_to user   # user is redirected to their profile page
    else
      flash.now[:danger] = 'Invalid email/password combination'  
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
