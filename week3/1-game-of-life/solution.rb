module GameOfLife

class Board
  include Enumerable
  attr_accessor :population

  def each
     if block_given?
      @population.each {|cell| yield(cell)}
     else
      @population.enum_for (:each)
     end
  end

  def initialize *cells
    @population = cells.uniq
  end

  def [] x, y
    member? [x, y]
  end

  def neighbours member
    x, y = member
    [[x+1, y], [x-1, y], [x, y+1], [x, y-1],
     [x-1, y+1], [x+1, y+1], [x+1, y-1], [x-1, y-1]]
  end

  def alive_neighbours_count member
    (@population & neighbours(member)).count
  end

  def survivors
    @population.select { |living| [2,3].member? alive_neighbours_count living }
  end

  def resurrected
       dead_neighbours = []
       each { |living| dead_neighbours |= neighbours(living) }
       dead_neighbours -= @population
       dead_neighbours.select { |neighbour| alive_neighbours_count(neighbour) == 3 }
  end

  def next_generation
    Board.new *(survivors + resurrected)
  end
end
end

