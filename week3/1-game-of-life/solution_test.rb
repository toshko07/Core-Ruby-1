require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def test_the_truth
    assert true
  end
end

class BoardTest < Minitest::Test
  include GameOfLife
  def test_board_initialization
    board = Board.new [1, 2], [2, 3], [3, 4]

    assert_equal [[1, 2], [2, 3], [3, 4]], board.population
  end

  def test_is_it_member?
    board = Board.new [1,2], [2, 3], [3, 4]

    assert_equal true, board[1,2]
    assert_equal false, board[2,5]
  end

  def test_neighbours
    board = Board.new

    assert_equal [[2, 2], [0, 2], [1, 3], [1, 1], [0, 3], [2, 3], [2, 1], [0, 1]],
                  board.neighbours([1, 2])
  end

  def test_alive_neighbours_count
    board = Board.new [2,3], [0,1], [6,7]

    assert_equal 2, board.alive_neighbours_count([1, 2])
    assert_equal 0, board.alive_neighbours_count([8, 9])
  end

  def test_survivors
    board = Board.new [1, 2], [2, 3], [4,5], [1,1], [0, 1]

    assert_equal [[1, 2], [1, 1], [0, 1]], board.survivors
  end

  def test_resurrected
    board = Board.new [1, 2], [2, 3], [4,5], [1,1], [0, 1]

    assert_equal [[2, 2], [0, 2]], board.resurrected
  end

  def test_next_generation
    board = Board.new [1, 2], [2, 3], [4,5], [1,1], [0, 1]

    assert_equal [[1, 2], [1, 1], [0, 1], [2, 2], [0, 2]],
                 board.next_generation.population
  end

end

