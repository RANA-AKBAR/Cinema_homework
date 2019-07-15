class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

      def booking
        sql ="SELECT * FROM films
        INNER JOIN tickets
        ON tickets.film_id=films.id
        WHERE tickets.customer_id = $1"
        values=[@id]
        films_array_of_hashes = SqlRunner.run(sql,values)
        return films_array_of_hashes.map { |film|  Film.new(film).title()}
      end

      def booking
        sql ="SELECT * FROM films
        INNER JOIN tickets
        ON tickets.film_id=films.id
        WHERE tickets.customer_id = $1"
        values=[@id]
        films_array_of_hashes = SqlRunner.run(sql,values)
        return films_array_of_hashes.map { |film|  Film.new(film).title()}
      end

      # def joins
      #   sql ="SELECT * FROM customers
      #   INNER JOIN tickets
      #   ON customers.id = tickets.customer_id"
      #   ticket = SqlRunner.run(sql)
      #   return ticket.map { |tickets|  Ticket.new(tickets)}
      # end

    def save()
      sql ="INSERT INTO customers(name, funds) VALUES($1, $2)
      RETURNING id"
      values =[@name, @funds]
      @id  = SqlRunner.run(sql, values)[0]['id']
    end

    def read()
      sql="SELECT * FROM customers WHERE id = $1"
      values =[@id]
      result = SqlRunner.run(sql, values)
      return result.map { |customer|Customer.new(customer)  }
    end

    def update()
      sql = "UPDATE customers SET(name, funds) = ($1, $2) WHERE id = $3"
      values =[@name, @funds, @id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "DELETE FROM customers
      WHERE id = $1"
      values =[@id]
      SqlRunner.run(sql,values)
    end

    def self.delete_all()
      sql = "DELETE FROM customers"
      SqlRunner.run(sql)
    end

    def self.all()
      sql = "SELECT * FROM customers"
      customers_array_of_hashes = SqlRunner.run(sql)
      return customers_array_of_hashes.map { |hash_of_customer| Customer.new(hash_of_customer) }
    end

    def charge()
  sql = "SELECT * FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE
  tickets.customer_id = $1 "
  values = [@id]
  movie =  SqlRunner.run(sql, values)
  movie_price = movie.map { |movie| Film.new(movie)  }
   movie_price.each {|movie| @funds -= movie.price.to_i}
   return @funds
end


  def number_of_tickets
    sql = "SELECT * FROM tickets WHERE tickets.customer_id = $1"
    values = [@id]
    result= SqlRunner.run(sql,values)
    tickets = result.map { |ticket| Ticket.new(ticket) }
    return tickets.count()
  end

end
