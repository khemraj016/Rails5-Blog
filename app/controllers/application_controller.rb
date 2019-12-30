class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_user!
    unless user_signed_in?
      flash[:alert] = I18n.t('unauthorized.login')
      redirect_to root_path
    end
  end

  protected
   
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
