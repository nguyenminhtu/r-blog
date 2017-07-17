class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:update, keys: [:avatar])
  end
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
