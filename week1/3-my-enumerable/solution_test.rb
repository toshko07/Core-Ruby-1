require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  class Collection
    include MyEnumerable

    def initialize(*data)
      @data = data
    end

    def each(&block)
      @data.each(&block)
    end
  end

  def test_map
    collection = Collection.new(*1..5)

    assert_equal [2, 3, 4, 5, 6], collection.map(&:succ)
<<<<<<< HEAD
    assert_equal true, collection.map.is_a?(Enumerator)
=======
>>>>>>> upstream/master
  end

  def test_filter
    collection = Collection.new(*1..10)

    assert_equal [1, 3, 5, 7, 9], collection.filter(&:odd?)
<<<<<<< HEAD
    assert_equal true, collection.filter.is_a?(Enumerator)
=======
>>>>>>> upstream/master
  end

  def test_reject
    collection = Collection.new(*1..10)

    assert_equal [1, 3, 5, 7, 9], collection.reject(&:even?)
<<<<<<< HEAD
    assert_equal true, collection.reject.is_a?(Enumerator)
=======
>>>>>>> upstream/master
  end

  def test_reduce
    collection = Collection.new(*1..10)

    assert_equal 55, collection.reduce(0) { |sum, n| sum + n }
  end

  def test_include?
    collection = Collection.new(*1..10)

    assert_equal true, collection.include?(5)
  end

  def test_any?
    collection = Collection.new(%w[ant bear cat])

    assert_equal true, collection.any? { |word| word.length >= 3 }
  end

  def test_one?
    collection = Collection.new(*%w[ant bear cat])

    assert_equal true, collection.one? { |word| word.length == 4 }
  end

  def test_all?
    collection = Collection.new(%w[ant bear cat])

    assert_equal false, collection.all? { |word| word.length == 4 }
  end

  def test_count(element = nil)
    collection = Collection.new(1, 2, 4, 2)

    assert_equal 4, collection.count
    assert_equal 2, collection.count(2)
    assert_equal 3, collection.count { |x| x%2==0 }
  end

  def test_size
  collection = Collection.new(1, 2, 4, 2)

  assert_equal 4, collection.size
  end

  def test_group_by
    collection = Collection.new(*1..6)

    assert_equal collection.group_by { |i| i%3 },
                {0=>[3, 6], 1=>[1, 4], 2=>[2, 5]}
    assert_equal true, collection.group_by.is_a?(Enumerator)
  end

  def test_min
    collection = Collection.new(*1..10)
    word_collection = %w(albatross dog horse)

    assert_equal 'dog', word_collection.min { |a, b| a.length <=> b.length }
    assert_equal 1, collection.min
  end

  def test_min_by
    collection = %w(albatross dog horse)

    assert_equal 'dog', collection.min_by(&:length)
  end

  def test_max
    collection = Collection.new(*1..10)

    word_collection = %w(albatross dog horse)
    assert_equal 'albatross', word_collection.max{|a, b| a.length <=> b.length}
    assert_equal 10, collection.max
  end

  def test_max_by
    collection = Collection.new(*1..10)

    word_collection = %w(albatross dog horse)
    assert_equal 'albatross', word_collection.max_by(&:length)
    assert_equal true, collection.max_by.is_a?(Enumerator)
  end

  def test_minmax
    collection = Collection.new(*1..10)

    word_collection = %w(albatross dog horse)
    assert_equal %w(dog albatross),
                 word_collection.minmax { |a, b| a.length <=> b.length }
    assert_equal [1, 10], collection.minmax
  end

  def test_minmax_by
    collection = Collection.new(*1..10)

    word_collection = %w(albatross dog horse)
    assert_equal %w(dog albatross), word_collection.minmax_by(&:length)
    assert_equal true, collection.minmax_by.is_a?(Enumerator)
  end

  def test_take
    collection = Collection.new(*1..10)

    assert_equal [1, 2, 3], collection.take(3)
  end

  def test_take_while
    collection = [1, 2, 3, 4, 5, 0]

    assert_equal [1, 2], collection.take_while { |i| i < 3 }
    assert_equal true, collection.take_while.is_a?(Enumerator)
  end

  def test_drop
    collection = Collection.new(*1..10)

    assert_equal [9, 10], collection.drop(8)
  end

  # def test_drop_while
  #   collection = [1, 2, 3, 4, 5, 0]

  #   assert_equal [3, 4, 5, 0], collection.drop_while { |i| i < 3 }
  #   assert_equal true, collection.drop_while.is_a?(Enumerator)
  # end

end
