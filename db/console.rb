require_relative('../petshop')
require_relative('../pet')
require_relative('../customer')
require_relative('../sale')
require_relative('sql_runner')
require('pry-byebug')

runner = SqlRunner.new({dbname: 'pet_shop_chain', host: 'localhost'})

petshop1 = PetShop.new( {'name' =>'Joes Domestic Animals', 'type' => 'domestic', 'address' => '123 Fake Street'}, runner )
petshop1.save()

pet1 = Pet.new( {'name' => 'Jazz', 'species' => 'Cat', 'type' => 'domestic', 'pet_shop_id' => petshop1.id, 'price' => '100', 'sold' => 'false'}, runner )
pet2 = Pet.new( {'name' => 'Lilly', 'species' => 'Cat', 'type' => 'domestic', 'pet_shop_id' => petshop1.id, 'price' =>' 120', 'sold' => 'false'}, runner )
pet3 = Pet.new( {'name' => 'Molly', 'species' => 'Dog', 'type' => 'domestic', 'pet_shop_id' => petshop1.id, 'price' => '150', 'sold' => 'false'}, runner )

customer1 = Customer.new( {'name'=> 'Joe', 'address' => '2 Southchesters Park, Bonnyrigg, EH19 3GE', 'tel' => '07539271620'}, runner )

sale1 = Sale.new( {'customer_id' => '1', 'pet_id' => '1'}, runner )
sale2 = Sale.new( {'customer_id' => '1', 'pet_id' => '2'}, runner )
sale3 = Sale.new( {'customer_id' => '1', 'pet_id' => '3'}, runner )

pet1.save()
pet2.save()
pet3.save()
customer1.save()
sale1.save()
sale2.save()
sale3.save()

binding.pry
nil