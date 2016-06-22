class Sale
  attr_reader(:id, :customer_id, :pet_id)
  def initialize(options, runner)
    @id = options['id']
    @customer_id = options['customer_id']
    @pet_id = options['pet_id']
    @runner = runner
  end

  def save()
    sql = "INSERT INTO sales (customer_id, pet_id) VALUES ('#{@customer_id}', '#{@pet_id}') RETURNING *"
    sale_info = @runner.run(sql)
    @id = sale_info.first['id'].to_i
  end

end