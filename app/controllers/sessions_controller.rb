class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user = User.find_by(email: params[:email]) # || User.find_by(email: params[:username])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.signed[:user_id] = { value: user.id, expires: 2.weeks.from_now }
      else
        # expires at the end of the browser session
        cookies.signed[:user_id] = user.id
      end
      redirect_to root_path
    else
      flash[:error] = 'Invalid user/password combination.'
      redirect_to login_path
    end
  end


  def destroy
    cookies.delete :user_id
    redirect_to login_url, notice: "Logged out"
  end
end
