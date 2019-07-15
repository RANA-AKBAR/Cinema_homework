

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

    def audience_size
      sql = "SELECT * FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id
      WHERE tickets.film_id = $1"
      values = [@id]
      result = SqlRunner.run(sql, values)
      audience_memebers = result.map { |customer| Customer.new(customer) }
      return audience_memebers.count()
    end

    def save
      sql = "INSERT INTO films(title, price) VALUES ($1, $2) RETURNING id"
      values = [@title, @price]
      @id = SqlRunner.run(sql, values)[0]['id']
    end

    def read
      sql = "SELECT * FROM films WHERE id = $1"
      values = [@id]
      result = SqlRunner.run(sql, values)
      return result.map { |film|Film.new(film)  }
    end

    def update
      sql = "UPDATE films SET(title, price) = ($1, $2) WHERE id = $3"
      values = [@title, @price, @id]
      return SqlRunner.run(sql, values)
    end

    def delete
      sql = "DELETE FROM films WHERE id = $1"
      values = [@id]
      return SqlRunner.run(sql, values)
    end

    def self.delete_all
      sql = "DELETE FROM films"
      return SqlRunner.run(sql)
    end

    def self.all
      sql = "SELECT * FROM films"
      film_array_of_hashes = SqlRunner.run(sql)
      return film_array_of_hashes.map { |film| Film.new(film)}
    end

end
