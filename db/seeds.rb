# User.create!(email: 'admin@gmail.com', password: '123456', password_confirmation: '123456')

PublicActivity.enabled = false
30.times do 
  Hostel.create!([{
    name: Faker::FunnyName.name_with_initial,
    address: Faker::Address.full_address,
    description: Faker::TvShows::GameOfThrones.quote, 
    user_id: User.first.id
  }])
end
PublicActivity.enabled = true