require_relative('../petshop')
require_relative('../pet')
require_relative('sql_runner')
require('pry-byebug')

runner = SqlRunner.new({dbname: 'pet_shop_chain', host: 'localhost'})

petshop1 = PetShop.new( {'name' =>'Joes Domestic Animals', 'type' => 'domestic', 'address' => '123 Fake Street'}, runner )
petshop1.save()

pet1 = Pet.new( {'name' => 'Jazz', 'species' => 'Cat', 'type' => 'domestic', 'pet_shop_id' => petshop1.id}, runner )
pet2 = Pet.new( {'name' => 'Lilly', 'species' => 'Cat', 'type' => 'domestic', 'pet_shop_id' => petshop1.id}, runner )
pet3 = Pet.new( {'name' => 'Molly', 'species' => 'Dog', 'type' => 'domestic', 'pet_shop_id' => petshop1.id}, runner )

pet1.save()
pet2.save()
pet3.save()


binding.pry
nil