class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        remember user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else 
        message = "Account not activated"
        message += "Check your email for the activation link"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      #flash.now makes the flash disappear as soon as there is an additional request
      flash.now[:danger] = "Invalid username/password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in? #to prevent errors when user open site with multiple browsers
    redirect_to root_url
  end
end
