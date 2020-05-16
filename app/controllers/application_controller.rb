class ApplicationController < ActionController::Base

  before_action :authorize

  helper_method :current_user, :signed_in?


  def signed_in?
    current_user.present?
  end

  private

  def current_user
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end

  protected
  def authorize
    unless User.find_by(id: cookies.signed[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end

end
