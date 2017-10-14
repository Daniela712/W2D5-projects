class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.to_s.chars.reduce(0){|acc, i| acc.hash+i.ord.hash}.hash
  end
end

class String
  def hash
    self.chars.hash
  end
end

class Hash

  def hash
    self.to_s.chars.sort.hash
  end
end
