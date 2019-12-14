# frozen_string_literal: true

module MoviesHelper
  def current_category_class(category = nil)
    params[:category] == category  && 'active disable'
  end
end
