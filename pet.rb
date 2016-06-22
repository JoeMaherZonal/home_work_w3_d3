class Pet
  attr_reader(:id, :name, :type, :species, :pet_shop_id, :price, :sold)
  def initialize(options, runner)
    @id = options['id']
    @name = options['name']
    @type = options['type']
    @species = options['species']
    @pet_shop_id = options['pet_shop_id']
    @price = options['price'].to_i
    @sold = to_bool( options['false'] )
    @runner = runner
  end

  def to_bool(str)
    return str == 'true'
  end

  def update(options)
    set_new_values(options)
    sql = "UPDATE pets SET
    name = '#{@name}', type = '#{@type}', species = '#{@spcies}', pet_shop_id = '#{@pet_shop_id}' WHERE id = #{@id} " 
    @runner.run(sql)
  end

  def set_new_values(options)
    @name = options['name'] if (options['name'])
    @type = options['type'] if (options['type'] )
    @address = options['species'] if (options['species'])
    @price = options['price'] if (options['price'] )
    @price = sold['sold'] if (options['sold'] )
    if (options['pet_shop_id']) && ( pet_shop_exists?(options['pet_shop_id']) )
      @pet_shop_id = options['pet_shop_id']
    end
  end

  def pet_shop_exists?(id)
    sql = "SELECT * FROM pet_shops WHERE id = #{id}"
    pet_shop_data = @runner.run(sql)
    pet_shop = pet_shop_data.map{|shop| shop}
    return pet_shop.length > 0
  end

 def save()
   sql = "INSERT INTO pets (name, type, species, pet_shop_id, price, sold) VALUES ('#{@name}', '#{@type}', '#{@species}', '#{@pet_shop_id}', '#{@price}', '#{@sold}') RETURNING *"
   pet_info = @runner.run(sql)
   @id = pet_info.first['id'].to_i
 end

 def shop()
  sql = "SELECT * FROM pet_shops WHERE id = #{pet_shop_id} RETURNING *"
  pet_shop_data = @runner.run(sql)
  pet_shop = PetShop.new(pet_shop_data.first, @runner)
  return pet_shop
 end

 def self.pet_by_id(pet_id, runner)
  sql = "SELECT * FROM pets WHERE id = #{pet_id}"
  pet_data = runner.run(sql)
  pet = Pet.new(pet_data.first, runner)
  return pet
 end

 def self.pets(runner)
   sql = "SELECT * FROM pets"
   pets_data = runner.run(sql)
   pets = pets_data.map {|pet| Pet.new(pet, runner)}
   return pets
 end

 def delete()
  sql = "DELETE FROM pets WHERE id = #{@id}"
  @runner.run(sql)
 end

end