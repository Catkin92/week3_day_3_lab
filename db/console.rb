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
