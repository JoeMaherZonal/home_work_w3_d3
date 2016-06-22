class PetShop
  attr_reader(:id, :name, :type, :address)
  def initialize(options, runner)
    @id = options['id']
    @name = options['name']
    @type = options['type']
    @address = options['address']
    @runner = runner
  end

  def update(options)
    set_new_values(options)
    sql = "UPDATE pet_shops SET name = '#{@name}', type = '#{@type}', address = '#{@address}' 
    WHERE id = #{@id} " 
    @runner.run(sql)
  end

  def set_new_values(options)
    @name = options['name'] if (options['name'])
    @type = options['type'] if (options['type'] )
    @address = options['address'] if (options['address'])
  end

  def save()
    sql = "INSERT INTO pet_shops (name, type, address) VALUES ('#{@name}', '#{@type}', '#{@address}') RETURNING *"
    pet_shop_info = @runner.run(sql)
    @id = pet_shop_info.first['id'].to_i
  end

  def check_if_empty?()
    sql = "SELECT * FROM pets WHERE pet_shop_id = #{@id}"
    pets_data = @runner.run(sql)
    pets_array = pets_data.map {|pet| pet}
    return  pets_array.length == 0
  end

  def delete_pets()
    sql = "SELECT * FROM pets WHERE pet_shop_id = #{@id}"
    pets_data = @runner.run(sql)
    pets_array = pets_data.map {|pet| pet}
    pets_array.each do |pet|
      sql = "DELETE FROM pets where id = #{pet['id']}"
      @runner.run(sql)
    end
  end

  def delete()
    if check_if_empty?
      check_if_empty?()
      sql = "DELETE FROM pet_shops WHERE id = #{@id}"
      @runner.run(sql)
    else
      return
    end
  end

  def pets()
    sql = "SELECT * FROM pets WHERE pet_shop_id = #{@id} RETURNING *"
    pets_data = @runner.run(sql)
    pets = pets_data.map{ |pet| Pet.new(pet, @runner) }
    return pets
  end

  def self.store_by_id(pet_shop_id, runner)
   sql = "SELECT * FROM pet_shops WHERE id = #{pet_shop_id} RETURNING *"
   pet_shop_data = runner.run(sql)
   pet_shop = PetShop.new(pet_shop_data.first, runner)
   return pet_shop
  end

  def self.stores(runner)
    sql = "SELECT * FROM pet_shops"
    pet_shop_data = runner.run(sql)
    pet_shops = pet_shop_data.map {|pet_shop| PetShop.new(pet_shop, runner)}
    return pet_shops
  end

end