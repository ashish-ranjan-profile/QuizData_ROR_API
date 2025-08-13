require 'faker'

50.times do |i|
  place = Place.create!(
    name: Faker::Address.street_address,
    description: Faker::Lorem.paragraph,
    state: Faker::Address.state,
    city: Faker::Address.city,
    country: Faker::Address.country
  )
  puts "Place #{i + 1} created successfully"

  10.times do
    place.images.create!(
      url: 'https://www.planetware.com/wpimages/2019/11/india-best-places-to-visit-agra.jpg'
    )
  end
end
