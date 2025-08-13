class Api::V1::PlacesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_place, only: %i[show update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @places = Place.includes(:images).all
    render json: @places.as_json(include: { images: { only: [ :id, :url ] } })
  end

  def show
    render json: @place.as_json(include: { images: { only: [ :id, :url ] } })
  end

  def create
    @place = Place.new(place_params)

    if @place.save
      render json: @place.as_json(include: { images: { only: [ :id, :url ] } }), status: :created
    else
      render json: { errors: @place.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @place.update(place_params)
      render json: @place.as_json(include: { images: { only: [ :id, :url ] } })
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @place.destroy
    render json: { message: "Place deleted successfully" }
  end

  private

  def set_place
    @place = Place.find_by(id: params[:id])
    unless @place
      render json: { error: "Place not found" }, status: :not_found
      nil
    end
  end

  def place_params
  params.require(:place).permit(
    :name, :description, :state, :city, :country,
    images_attributes: [ :id, :url ]
  )
  end


  def not_found
    render json: { error: "Record not found" }, status: :not_found
  end
end
