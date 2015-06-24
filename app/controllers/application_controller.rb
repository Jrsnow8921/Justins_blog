class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  check_authorization unless: :devise_controller?

  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :set_csrf_cookie_for_ng

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message

    respond_to do |format|
      format.html do
        session[:user_return_to] = request.url if !signed_in? && request.get?
        redirect_to root_url
      end
      format.json do
        render json: flash, status: :unauthorized
        flash.delete( :error )
      end
      format.js do
        render 'shared/error'
        flash.delete( :error )
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for( :sign_up ) << :username
    devise_parameter_sanitizer.for( :sign_up ) << :password_confirmation

    devise_parameter_sanitizer.for( :sign_in ) << :username
    devise_parameter_sanitizer.for( :sign_in ) << :password_confirmation

    devise_parameter_sanitizer.for( :account_update ) << :username
    devise_parameter_sanitizer.for( :account_update ) << :password_confirmation
  end

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end
end
