class Array
  def to_hash
    Hash[*self.flatten]
  end

  def index_by
    lastwords_array = self.map { |arg| yield(arg) }
    zipped_array = lastwords_array.zip(self)
    Hash[*(zipped_array.flatten)]
  end

  def subarray_count(arr)
    count = 0
    new_arr = self.each_cons(arr.size)
    new_arr.each {|el| count += 1 if arr == el }
    count
  end

  def occurences_count
    self.reduce(Hash.new(0)) { |total, e| total[e] += 1 ;total}
  end

end
