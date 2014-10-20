class Hash
  def pick(*keys)
  self.select {|key| keys.include? key}
  end

    def except(*keys)
    self.select {|key|  !keys.include? key }
  end

    def compact_values
    self.select {|key, value| value }
  end
    def defaults(hash)
    self.merge!(hash) {|key,v1,v2| v1}
  end
end
