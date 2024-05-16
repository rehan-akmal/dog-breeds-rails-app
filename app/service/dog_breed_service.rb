require 'net/http'

class DogBreedService
  BASE_URL = ENV.fetch('DOG_API_BASE_URL')

  def self.fetch_breeds
    url = URI("#{BASE_URL}/breeds/list/all")
    response = Net::HTTP.get(url)
    result = JSON.parse(response)

    if result['status'] == 'success'
      result['message'].keys
    else
      []
    end
  end

  def self.fetch_breed_image(breed)
    url = URI("#{BASE_URL}/breed/#{breed}/images/random")
    response = Net::HTTP.get(url)
    result = JSON.parse(response)

    if result['status'] == 'success'
      result['message']
    else
      nil
    end
  end
end
