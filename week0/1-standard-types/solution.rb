def prime?(n)
  if n.even?
    return false
  else
    return true
  end
end


def ordinal(n)
  ten_reminder = n%10

  if ten_reminder == 1
      "#{n}st"

    elsif ten_reminder == 2
      if n <= 100
      "#{n}nd"
     elsif n > 100
      "#{n}th"
    end

    elsif ten_reminder == 3
      "#{n}rd"

     else
      "#{n}th"
     end
end

def palindrome?(object)

  object = object.to_s.downcase.split.join('')
  object == object.reverse

end

def anagram?(word, other)
  if word.strip.downcase.chars.sort.join == other.strip.downcase.chars.sort.join
    return true
  else
    return false
  end
end

def remove_prefix(string, pattern)
  string.gsub(pattern, '')
end

def remove_suffix(string, pattern)
  string.gsub(pattern, '')
end

def digits(n)
  n.to_s.chars.map(&:to_i)
end

def fizzbuzz(range)
  output = []
 range.each do |x|
  m3 = x%3 == 0
  m5 = x%5 == 0

   temp =   case
    when (m3 and m5) then :fizzbuzz
    when m3 then :fizz
    when m5 then :buzz
    else x
   end
output.push(temp)

 end
 return output
end


def histogram(string)
  arr = string.split(//)
  arr.reduce(Hash.new(0)) { |total, e| total[e] += 1 ;total}
end

def count(array)
  array.reduce(Hash.new(0)) { |total, e| total[e] += 1 ;total}
end
