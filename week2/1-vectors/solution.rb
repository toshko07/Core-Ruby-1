class Vector2D
  attr_accessor :x, :y


  # The unit vector (1, 0).
  def self.e
    Vector2D.new(1,0)
  end

  # The unit vector (0, 1).
  def self.j
    Vector2D.new(0,1)
  end

  def initialize(x, y)
    @x = x
    @y = y
  end

  def length
    (@x**2 + @y**2)**0.5
  end

  def magnitute
    alias magnitute length
  end

  def normalize
    Vector2D(@x/self.length, @y/self.length)
  end

  def ==(vector)
    @x == vector.x and @y == vector.y ? true : false
  end

  def +(other)
    if other.is_a? Numeric
      @x, @y = @x + other, @y + other
    else
      @x, @y = @x + other.x, @y + other.y
    end
  end

  def -(other)
    if other.is_a? Numeric
      @x, @y = @x - other, @y - other
    else
      @x, @y = @x - other.x, @y - other.y
    end
  end

  def *(scalar)
    @x, @y = @x * scalar, @y * scalar
  end

  def /(scalar)
    @x, @y = @x / scalar, @y / scalar
  end

  def to_s
    "<Vector2D: #{object_id} @x = #{@x} @y = #{@y}>"
  end

  def inspect
    [[@x, @y], object_id]
  end
end


class Vector
  attr_accessor :vector

  def initialize(*components)
    @vector = components.flatten
  end

  def dimension
    @vector.size
  end

  def length
    result = 0
    @vector.map { |el| result += el**2 }
    result ** 0.5
  end

  def magnitude
  end

  def normalize
    @vector = @vector.map { |element| element/length }
  end

  def [](index)
    @vector[index]
  end

  def []=(index, number)
    @vector[index]= number
    @vector
  end

  def ==(other)
    @vector == other.vector
  end

  def +(vector_of_same_dimension_or_scalar)
    if vector_of_same_dimension_or_scalar.is_a? Numeric
      @vector = @vector.map {|el| el + vector_of_same_dimension_or_scalar}
    elsif dimension == vector_of_same_dimension_or_scalar.dimension
     @vector = @vector.zip(vector_of_same_dimension_or_scalar.vector).map {|el| el.reduce(:+)}
    end
  end

  def -(vector_of_same_dimension_or_scalar)
    if vector_of_same_dimension_or_scalar.is_a? Numeric
      @vector = @vector.map {|el| el - vector_of_same_dimension_or_scalar}
    elsif dimension == vector_of_same_dimension_or_scalar.dimension
     @vector = @vector.zip(vector_of_same_dimension_or_scalar.vector).map {|el| el.reduce(:-)}
    end
  end

  def *(scalar)
    @vector = @vector.map { |el| el * scalar}
  end

  def /(scalar)
    @vector = @vector.map { |el| el / scalar }
  end

  def to_s
    "Vector: #{object_id}, #{@vector}"
  end

  def inspect
    [@vector, object_id]
  end

  alias :magnitude :length
end
