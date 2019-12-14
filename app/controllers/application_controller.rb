# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :can_manage?
  helper_method :can_rate?

  protected

  def authenticate_admin!
    redirect_to root_path, alert: 'Not Found' unless current_user && current_user.admin?
  end

  def after_sign_in_path_for(_resource)
    movies_path
  end

  def after_sign_up_path_for(_resource)
    movies_path
  end

  def can_manage?
    user_signed_in? && current_user.admin?
  end

  def can_rate?
    user_signed_in?
  end
end
