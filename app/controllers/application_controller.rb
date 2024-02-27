class ApplicationController < ActionController::API
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
  end
end
