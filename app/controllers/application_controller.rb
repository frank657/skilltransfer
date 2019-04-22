class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if current_user.professionals.empty? && current_user.teachers.empty?
      signup_form_professional_path
    else
      current_user.professionals.empty? ? user_path(current_user.id) : p_dashboard_path(current_user.id)
    end
  end
end
