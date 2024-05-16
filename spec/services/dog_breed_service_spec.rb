require 'rails_helper'

RSpec.describe DogBreedService, type: :service do
  describe '.fetch_breeds' do
    context 'when the API returns a successful response' do
      before do
        response_body = {
          status: 'success',
          message: { 'labrador' => [], 'poodle' => [] }
        }.to_json

        stub_request(:get, "#{ENV['DOG_API_BASE_URL']}/breeds/list/all")
          .to_return(status: 200, body: response_body, headers: {})
      end

      it 'returns a list of breeds' do
        breeds = DogBreedService.fetch_breeds
        expect(breeds).to eq(['labrador', 'poodle'])
      end
    end

    context 'when the API returns an unsuccessful response' do
      before do
        response_body = { status: 'error', message: 'something went wrong' }.to_json

        stub_request(:get, "#{ENV['DOG_API_BASE_URL']}/breeds/list/all")
          .to_return(status: 500, body: response_body, headers: {})
      end

      it 'returns an empty array' do
        breeds = DogBreedService.fetch_breeds
        expect(breeds).to eq([])
      end
    end
  end

  describe '.fetch_breed_image' do
    context 'when the API returns a successful response' do
      let(:breed) { 'labrador' }

      before do
        response_body = {
          status: 'success',
          message: 'https://images.dog.ceo/breeds/labrador/n02099712_9850.jpg'
        }.to_json

        stub_request(:get, "#{ENV['DOG_API_BASE_URL']}/breed/#{breed}/images/random")
          .to_return(status: 200, body: response_body, headers: {})
      end

      it 'returns the image URL' do
        image_url = DogBreedService.fetch_breed_image(breed)
        expect(image_url).to eq('https://images.dog.ceo/breeds/labrador/n02099712_9850.jpg')
      end
    end

    context 'when the API returns an unsuccessful response' do
      let(:breed) { 'invalid_breed' }

      before do
        response_body = { status: 'error', message: 'Breed not found' }.to_json

        stub_request(:get, "#{ENV['DOG_API_BASE_URL']}/breed/#{breed}/images/random")
          .to_return(status: 404, body: response_body, headers: {})
      end

      it 'returns nil' do
        image_url = DogBreedService.fetch_breed_image(breed)
        expect(image_url).to be_nil
      end
    end
  end
end
