# spec/controllers/breeds_controller_spec.rb
require 'rails_helper'

RSpec.describe BreedsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      allow(DogBreedService).to receive(:fetch_breeds).and_return(['Labrador', 'Poodle'])

      get :index

      expect(response).to be_successful
      expect(assigns(:breeds)).to eq(['Labrador', 'Poodle'])
    end
  end

  describe 'GET #fetch_breed_image' do
    context 'when the breed is found' do
      it 'returns the image URL' do
        allow(DogBreedService).to receive(:fetch_breed_image).with('Labrador').and_return('http://example.com/labrador.jpg')

        get :fetch_breed_image, params: { breed: 'Labrador' }

        expect(response).to be_successful
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)).to eq({ 'image_url' => 'http://example.com/labrador.jpg' })
      end
    end

    context 'when the breed is not found' do
      it 'returns an error' do
        allow(DogBreedService).to receive(:fetch_breed_image).with('UnknownBreed').and_return(nil)

        get :fetch_breed_image, params: { breed: 'UnknownBreed' }

        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Breed not found' })
      end
    end
  end
end
