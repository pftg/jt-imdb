class RatingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @rating = find_or_build
    respond_to do |format|
      if @rating.save
        format.html { redirect_back fallback_location: movies_path, notice: 'Successfully rated.' }
        format.json { render :show, status: :created, location: @rating }
      else
        format.html { redirect_to movies_path, alert: 'There are problems with rating' }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end

  end

  private

  def find_or_build
    result = current_user.ratings.find_or_initialize_by(movie_id: create_params[:movie_id])
    result.assign_attributes(create_params)
    result
  end

  def create_params
    params.require(:rating).permit(:movie_id, :value)
  end
end
