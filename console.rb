require_relative "models/customer.rb"
require_relative "models/film.rb"
require_relative "db/sql_runner.rb"
require_relative "models/tickets.rb"
require'pry'


Customer.delete_all()
Film.delete_all

film1 = Film.new({'title' => 'Star wars', 'price' => 10})
film1.save
film2 = Film.new({'title' => 'die hard', 'price' => 12})
film2.save
film3 = Film.new({'title' => 'alladin', 'price' => 10})
film3.save
film4 = Film.new({'title' => 'driver', 'price' => 12})
film4.save
film5 = Film.new({'title' => 'bond', 'price' => 10})
film5.save
film6 = Film.new({'title' => 'terminator', 'price' => 12})
film6.save
film7 = Film.new({'title' => 'jackal', 'price' => 10})
film7.save

customer1 = Customer.new({'name' => 'john',
  'funds' => 50})
customer2 = Customer.new({'name' => 'paul',
  'funds' => 20})
customer3 = Customer.new({'name' => 'emma',
  'funds' => 220})
customer4 = Customer.new({'name' => 'harris',
  'funds' => 501})
customer5 = Customer.new({'name' => 'rodney',
  'funds' => 340})


customer1.save()
customer2.save()
customer3.save()
customer4.save()
customer5.save()

Customer.all

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id })
ticket5 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id })
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id })
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id })
ticket4 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film4.id })

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()

binding.pry
nil
