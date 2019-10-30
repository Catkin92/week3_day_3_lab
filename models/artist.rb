require('pg')
require_relative('../db/sql_runner.rb')
require_relative('album.rb')

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = "INSERT INTO artists(
    name)
    VALUES($1) RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def find_albums
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |album| Album.new(album) }
  end

  def update
    sql = "UPDATE artists SET
    name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM artists"
    result = SqlRunner.run(sql)
    return result.map { |artist| Artist.new(artist) }
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM artists WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values)
    artist_hash = result[0]
    return Artist.new(artist_hash)
  end

end
