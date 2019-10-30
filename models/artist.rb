require('pg')
require_relative('../db/sql_runner.rb')

class Artist

  attr_reader :name, :id

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

  def self.all
    sql = "SELECT * FROM artists"
    result = SqlRunner.run(sql)
    return result.map { |artist| Artist.new(artist) }
  end
end
