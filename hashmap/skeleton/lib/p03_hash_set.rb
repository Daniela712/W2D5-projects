require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 3)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num) && @count < num_buckets
      self[num].push(num)
      @count+=1
    elsif @count >= num_buckets
      resize!
      insert(num)
    end
  end

  def remove(num)
    if include?(num)
    self[num].delete(num)
    end
  end

  def include?(num)
    return true if self[num].include?(num)
    false
  end

  private

  def [](num)
    @store[num.hash%num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    oldstore=@store
    @store=(Array.new(oldstore.length*2){ Array.new })
    @count=0
    oldstore.each do |buckets|
      buckets.each{|el| insert(el)}
    end
  end
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
