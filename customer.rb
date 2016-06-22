require_relative('pet')

class Customer
  attr_reader(:id, :name, :address, :tel)
  def initialize(options, runner)
    @id = options['id']
    @name = options['name']
    @address = options['address']
    @tel = options['tel'].to_i
    @runner = runner
  end

  def save()
    sql = "INSERT INTO customers (name, address, tel) VALUES ('#{@name}', '#{@address}', '#{@tel}') RETURNING *"
    customer_info = @runner.run(sql)
    @id = customer_info.first['id'].to_i
  end

 def update(options)
   set_new_values(options)
   sql = "UPDATE customers SET name = '#{@name}', address = '#{@address}', tel = '#{@tel}' 
   WHERE id = #{@id} " 
   @runner.run(sql)
 end

 def set_new_values(options)
   @name = options['name'] if (options['name'])
   @address = options['address'] if (options['address'] )
   @tel = options['tel'] if (options['tel'])
 end

 def pets()
  sql = "SELECT pets.id, pets.name, pets.type, pets.species, ,pets.pet_shop_id, pets.price, pets.sold FROM pets INNER JOIN sales ON sales.pet_id = pets.id
  INNER JOIN customers ON sales.customer_id = customers.id WHERE sales.customer_id = #{@id}"
  pet_data = @runner.run(sql)
  pets = pet_data.map {|pet| Pet.new(pet, @runner) }
  return pets
 end
end