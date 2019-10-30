require_relative('../models/album.rb')
require_relative('../models/artist.rb')
require('pry')

artist1 = Artist.new( {
  'name' => 'Hoodoo Gurus'
  })

artist2 = Artist.new( {
  'name' => 'Temple'
  })

artist1.save
artist2.save

album1 = Album.new( {
  'name' => 'Stoneage Romeos',
  'genre' => 'Rock',
  'artist_id' => artist1.id
  })

album2 = Album.new ( {
  'name' => 'Hot Motion',
  'genre' => 'Rock',
  'artist_id' => artist2.id
  })

album1.save
album2.save
