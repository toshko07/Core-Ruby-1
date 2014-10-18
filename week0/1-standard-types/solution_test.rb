require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Unit::TestCase
  def test_the_truth
    assert_equal true, true
  end
     def test_prime_method
    assert_equal prime?(7), true
   end

   def test_ordinal_method
    assert_equal ordinal(2), "2nd"
    assert_equal ordinal(112), "112th"
   end

   def test_palindrome_method
    assert_equal palindrome?(12321), true
    assert_equal palindrome?('Race car'), true
   end

   def test_anagram_method
    assert_equal anagram?('silent', 'listen'), true
    assert_equal anagram?('Mr Mojo Risin', 'Jim Morisson'), false
   end

    def test_prefix_method
     assert_equal remove_prefix('Ladies Night Out','Ladies'), ' Night Out'
    end

    def test_suffix_method
     assert_equal remove_suffix('Ladies Night Out',' Night Out'), 'Ladies'
    end

def test_digits_method
  assert_equal digits(12345), [1, 2, 3, 4, 5]
end

  def test_histogram_method
  assert_equal histogram("abraca"), {"a"=>3, "b"=>1, "r"=>1, "c"=>1}
end


def test_fizzbuzz_method
  assert_equal fizzbuzz(1..7), [1, 2, :fizz, 4, :buzz, :fizz, 7]
end

  def test_count_method
  assert_equal count([1, 2, 3, 1]), {1=>2, 2=>1, 3=>1}
  assert_equal count(%w(this is an array of words words words)), {"this"=>1, "is"=>1, "an"=>1, "array"=>1, "of"=>1, "words"=>3}
end
end
