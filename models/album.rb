require('pg')
require_relative('../db/sql_runner.rb')
require_relative('artist.rb')

class Album

  attr_accessor :name, :genre
  attr_reader :artist_id, :id

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

  def find_artist
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    return result.map { |artist| Artist.new(artist) }
  end

  def update
    sql = "UPDATE albums SET(
    name,
    genre
    ) = ($1, $2) WHERE id = $3;"
    values = [@name, @genre, @id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM albums"
    result = SqlRunner.run(sql)
    return result.map { |album| Album.new(album) }
  end
end
