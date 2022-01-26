# frozen_string_literal: true

class ApplicationController < ActionController::Base

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :email, :password, :image) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:firstname, :lastname, :email, :password, :current_password, :image)
    end
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end

end
