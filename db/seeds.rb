User.create!(
  email: 'user@user.cuser',
  password: 'aaaaaaa'
)

Park.create!(
  name: "Boston Common",
  address: "139 Tremont Street",
  city: "Boston",
  state: "MA",
  zip: "02134",
  description: "Send it to Zoom!  There is a carousel!!"
)
Park.create!(
  name: "Public Garden",
  address: "139 Tremont Street",
  city: "Boston",
  state: "PA",
  zip: "02134",
  description: "Send it to Philly!!  There is a cheesesteak!!"
)
Park.create!(
  name: "Yellowstone",
  address: "139 Tremont Street",
  city: "Boston",
  state: "NJ",
  zip: "02134",
  description: "Send it to Atlantic City!  There is a shore!!"
)

Review.create!(
  rating: 5,
  body: 'Great for dog jumping',
  user_id: 1,
  park_id: 1
)
Review.create!(
  rating: 1,
  body: 'Not great for dog jumping',
  user_id: 1,
  park_id: 2
)
Review.create!(
  rating: 0,
  body: 'MY EYES ARE BLEEDING, FIRE EVERYWHERE, AAAAAAAAAAAH',
  park_id: 1,
  user_id: 1
)
