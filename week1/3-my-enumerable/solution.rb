module MyEnumerable

  def map
    return to_enum(:map) unless block_given?
    result = []
    each { |element| result << yield(element) }
    result
  end

  def filter
    return to_enum(:filter) unless block_given?
    result = []
    each { |element| result << element if yield(element) }
    result
  end
  def reject
    return to_enum(:reject) unless block_given?
    result = []
    each { |element| result << element unless yield(element) }
    result
  end
  def reduce(initial = nil)
   each { |value| initial = yield(initial, value) }
   initial
end
  def any?
    each { |element| return true if yield(element) }
    false
  end

  def one?
    match_counter = 0
    each { |element| match_counter += 1 if yield(element) }
    match_counter == 1
  end
  def all?
    each { |element| return false unless yield(element) }
    true
  end

  def each_cons(n)
    return to_enum(:each_cons) unless block_given?
    result = []
    each do |element|
    n.times { result << yield(element) }
    end
    result
  end
  def include?(element)
    each { |el| return true if el == element }
    false
  end
  def count(element = nil)
    counter = 0

    if block_given?
      each { |value| counter += 1 if yield(value) }
      counter
    elsif element == nil
      each { |value| counter += 1 }
      counter
    elsif element.kind_of?(Integer)
      each { |value| counter += 1 if value == element }
      counter
    end
  end
  def size
    counter = 0
    each { |element| counter += 1 }
    counter
  end
   def group_by
    return to_enum(:group_by) unless block_given?
    result = Hash.new { |h,k| h[k] = [] }
    each { |el| result[yield(el)] << el }
    Hash[result.sort]
   end

  def min
    result = 1.0 / 0.0
  if block_given?
    each { |item| result = item if yield(item) <= result }
  else
    each { |item| result = item if item <= result }
  end
  result
  end

  def min_by
    return to_enum(:min_by) unless block_given?
    result = 1.0 / 0.0
    each { |item| result = item if yield(item) <= result }
    result
  end
  def max
    result = -1.0 / 0.0
    if block_given?
      each { |item| result = item if yield(item) >= result }
    else
      each { |item| result = item if item >= result }
    end
    result
  end

  def max_by
    return to_enum(:max_by) unless block_given?
    result = 1.0 / 0.0
    each { |item| result = item if yield(item) >= result}
    result
  end

  def minmax
    [min, max]
  end

  def minmax_by
    return to_enum(:minmax_by) unless block_given?
    [min_by, max_by]
  end

  def take(n)
    result = []
    each  do |element|
      result << element
     return result if result.size == n
    end
    result
  end

  def take_while
    return to_enum(:take_while) unless block_given?
    result = []
    each { |element| yield(element)? result << element : false }
    result
  end

  def drop(n)
    result  = []
    counter = 0
    each do |element|
      counter += 1
      result << element unless counter <= n
    end
    result
  end

  def drop_while
    return to_enum(:drop_while) unless block_given?
    result = []
    each do |element|
      result << elemnet unless yield(elemnet)
    end
    result
  end

alias collect map
alias select filter
alias foldl reduce
end