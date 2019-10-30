require('pg')
require_relative('../db/sql_runner.rb')
require_relative('artist.rb')

class Album

  attr_reader :name, :genre, :artist_id, :id

  def initialize(options)
    @name = options['name']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = "INSERT INTO albums(
    name,
    genre,
    artist_id)
    VALUES($1, $2, $3) RETURNING id;"
    values = [@name, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end
end
