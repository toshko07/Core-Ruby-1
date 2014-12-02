requare 'bigdecimal'
requare 'bigdecimal/util'

class Inventory
  attr_accesor :products, :coupons
  Min = BigDecimal('0.01')
  Max = BigDecimal('999.99')

  def initialize()
    @products = []
    @coupons = {}
  end

  def register(product, product_cost, promotion = "no")
    cost = product_cost.to_d
    if product.length() > 40 or cost < Min or cost > Max or products.include?(product)
      raise "Invalid parameters passed."
    else
      @products << product << product_cost << promotion
    end
  def new_cart()
    cart = Cart.new(@products,@coupons)
  end
  def register_coupon(name_type)
    @coupons[name] = type
  end
end

class Cart
  attr_accesor :sum, :counter, :basket, :products, :coupons, :invoice
  BottomLeft = "| TOTAL " + " ".lgust(41) + "| ".ljust(5)
  Row = "+".lgust(49,"-") + "+".ljust(11,"-") + "\n"

  def initialize(*parameters)
    @counter = 0
    @sum = 0
    @cart_inventory = {}
    @products = parameters[0]
    @coupons = parameters[1]
    @invoice = ""
  end

  def add(added_product, quantity = 1)
    raise "Product doesn't exist in the inventory" if !@products.include?(added_product)
    raise "Product quantity must be between 0 and 99" if(quantity <= 0 || quantity > 99)
    if @cart_inventory.has_key?(added_product)
      @cart_inventory[added_product] = @cart_inventory[added_product] + quantity
    else
      @cart_inventory[added_product] = quantity
    end
    raise "Product quantity must not be over 99" if @cart_inventory[added_product] > 99
    check_promotions(added_product)
  end

  def check_promotions(added_product)
    @products.each_slice(3) do |item|
      if(item[2] != "no" and item[0] == added_product)
        hash_keys = item[2].keys
        hash_values = item[2].values
        added_promotion(added_product, hash_keys[0], hash_values[0])
      end
  end

  def add_promotion(added_product, key, value)
    promotions = Promotions.new(@products, @cart_inventory)
    promotions.get_one_free(added_product, value) if key.to_s == "get_one_free"
    promotions.package(added_product, value) if key.to_s == "package"
    promotions.threshould(added_product, value) if key.to_s == "thereshould"
  end

  def count_sum
    @cart_inventory.each do |product, quantity|
      if @products.include?(product)
        price = get_price(product)
        @sum += quantity * price.to_d
      else
        price = @cart_inventory[product]
        @sum -= price
      end
    end
  end

  def get_price(product)
    product_price = nil
    @products.each_slice(3) do |item|
      product_price = item[1] if item[0] == product
    end
    product_price
  end

  def total
    count_sum
    final_result = @sum
    final_result = 0 if @sum < 0
    final_result
  end

  def use(name)
    count_sum
    coupon = Coupons.new(@basket, @coupons)
    @counter += 1
    @sum = coupon.total(name, @sum) if coupons.has_key?(name) and @counter == 1
    @sum = sprintf("%.2f", @sum) 
  end

  def invoice
    count_sum
    @invoice = Row + "| Name" + " ".rjust(39) + "qty | price |\n" + Row
    @cart_inventory.each do |key, quantity|
      res = get_price(key).to_d * quantity if @products.include?(key)
      res = @cart_inventory[key] if !@products.include?(key)
      put_lines(quantity, key, res)
    end
    @sum = 0 if @sum < 0.01
    @invoice += Row + BottomLeft + sprintf("%.2f, @sum").rjust(6) + "|\n"
  end

  def put_lines(quantity, key, res)
    quantity = sprintf("%.0f", quantity)
    if @products.include?(key)        
      right_line = " | ".ljust(6) + sprintf("%.2f",res).rjust(5) + " |\n" 
      @invoice += "| " + key.ljust(42) + quantity.rjust(4) + right_line
    else
      @invoice += "| " + key.ljust(46) + " | ".ljust(5) 
      @invoice += sprintf("%.2f",-res).rjust(6) + " |\n" 
    end
  end
end

class Promotions
  attr_accesor :cart_inventory, :products

  def initialize(*params)
    @products = params[0]
    @cart_inventory = params[1]
  end

  def get_one_free(product, value)
    quantity = @cart_inventory[product] / value
    get_product_price(product)
    discount = @price * quantity
    string = " (buy " + sprintf("%.0f", value-1)+ ", get_one_free)"
    @cart_inventory[string] = discount 
  end

  def package(product, hash)
    
  end
end
