class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def handle_not_found
    redirect_to root_path, alert: t('errors.not_found', default: 'Resource not found')
  end
end
