class BreedsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @breeds = DogBreedService.fetch_breeds
  end

  def fetch_breed_image
    breed = params[:breed]
    image_url = DogBreedService.fetch_breed_image(breed)

    if image_url
      render json: { image_url: image_url }
    else
      render json: { error: 'Breed not found' }, status: :not_found
    end
  end
end