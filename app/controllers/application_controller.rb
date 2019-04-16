class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  # def after_sign_in_path_for(resource)
  #   current_user.professionals.empty? ? user_path(current_user.id) : p_dashboard_path(current_user.id)
  # end

  def after_sign_in_path_for(resource)
    if current_user.type == 'Teacher'
      new_teacher_path(current_user.id)
    else
      new_professional_path(current_user.id)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :type)}

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :current_password, :type)}
  end
end
