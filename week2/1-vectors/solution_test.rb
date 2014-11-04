require 'minitest/autorun'

require_relative 'solution'


class SolutionTest < Minitest::Test
  def test_the_truth
    assert true
  end

  def test_dimension
    vector = Vector.new(1,2,3,4)

    assert_equal 4, vector.dimension
  end

  def test_length
    vector = Vector.new(1,2,3,4)

    assert_equal 30**0.5, vector.length
  end

  def test_magnitude
    vector = Vector.new(1,2,3,4)

    assert_equal 30**0.5, vector.magnitude
  end

  def test_normalize
    vector = Vector.new(1,2,3,4)

    assert_equal [1/(30**0.5), 2/(30**0.5), 3/(30**0.5), 4/(30**0.5)],
                 vector.normalize
  end

  def test_get_coordinate
    vector = Vector.new(1,2,3,4)

    assert_equal 3, vector[2]
  end

  def test_set_coordinate
    vector = Vector.new(1,2,3,4)
    vector[0] = 0

    assert_equal [0, 2, 3, 4], vector.vector
  end

  def test_equal
    vector1 = Vector.new(1,2,3,4)
    vector2 = Vector.new(1,2,3,4)

    assert_equal true, vector1 == vector2
  end

  def test_addition
    vector1 = Vector.new(1,2,3,4)
    vector2 = Vector.new(1,2,3,4)
    number = 2

    assert_equal [2,4,6,8], vector1 + vector2
    assert_equal [4,6,8,10], vector1 + number
  end

  def test_subtraction
    vector1 = Vector.new(2,3,4,5)
    vector2 = Vector.new(1,2,3,4)
    number = 2

    assert_equal [1,1,1,1], vector1 - vector2
    assert_equal [-1,-1,-1,-1], vector1 - number
  end

  def test_multiplication
    vector = Vector.new(1,2,3,4)
    number = 2

    assert_equal [2,4,6,8], vector * number
  end

  def test_division
    vector = Vector.new(4,6,8,10)
    number = 2

    assert_equal [2,3,4,5], vector / number
  end

  def test_to_s
    vector = Vector.new(1,2,3,4)
    text = "Vector: #{vector.object_id}, [1, 2, 3, 4]"
    assert_equal text, vector.to_s
  end

  def test_inspect
    vector = Vector.new(1,2,3,4)
    assert_equal true, vector.inspect.include?(vector.object_id)
  end
end
