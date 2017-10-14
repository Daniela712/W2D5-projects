class MaxIntSet
  def initialize(max)
    @max=max
    @store=Array.new(max , false)
  end

  def insert(num)
    raise "Out of bounds" if num>@max || num<0
      @store[num-1]=true

  end

  def remove(num)
    raise "Out of bounds" if num>@max || num<0
      @store[num-1]=false
  end

  def include?(num)
    raise "Out of bounds" if num>@max  || num<0
    @store[num-1]

  end

  def is_valid?(num)

  end

  def validate!(num)

  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    unless include?(num)
      self[num].push(num)
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].include?(num)

  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num%num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
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
    # optional but useful; return the bucket corresponding to `num`
    @store[num%num_buckets]
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
