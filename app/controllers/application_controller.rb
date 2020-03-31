class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale

  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message  }
      format.js { render status: :forbidden }
      format.json { render json: { message: exception.message }, status: :forbidden }
    end
  end

  def default_url_options
    { lang: (I18n.locale unless I18n.locale == I18n.default_locale) }
  end

  private

  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end

end
