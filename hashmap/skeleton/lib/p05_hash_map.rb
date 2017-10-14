require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable

  def initialize(num_buckets = 8)
    @name="HASHMAP!!!!!!!!!!!!!"
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    self.each do |keyn, val|
      return true if key==keyn
    end
    false
  end

  def set(key, val)
    if !include?(key)
      if @count < num_buckets
        getbucket(key).append(key, val)
        @count += 1
      elsif
        resize!
        set(key, val)
      end
    else
      getbucket(key).update(key, val)
    end
    self
    # puts count
  end

  def get(key)
    @store[key.hash%num_buckets].get(key)
  end

  def delete(key)
    getbucket(key).remove(key)
    @count-=1
  end
  def each
    @store.each do |linkedList|
      linkedList.each do |node|
        yield(node.key, node.val)
      end
    end
  end
  def getbucket(key)
    @store[key.hash%num_buckets]

  end

  def show()
    self.each{|key, val| puts "key:#{key}  val:#{val}"}
    true
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end
  def [](key)
    @store[key.hash%num_buckets].get(key)
  end
    alias_method :[], :get
    alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    oldstore=@store
    @store=(Array.new(oldstore.length*2){ LinkedList.new })
    @count=0
    
    oldstore.each do |key, val|

      puts key
      puts val
      set(key,val)
    end
  end


end
