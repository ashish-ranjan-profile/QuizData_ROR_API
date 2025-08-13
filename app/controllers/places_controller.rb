class PlacesController < ApplicationController
  before_action :set_place, only: %i[show update destroy]

  def index
    @places = Place.all
    render json: @places
  end

  def show
    render json: @place
  end

  def update
    if @place.update(place_params)
      render json: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name, :description, :state, :city, :country)
  end
end
