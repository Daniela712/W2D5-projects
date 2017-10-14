class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next=@next
    @next.prev=@prev
  end
end

class LinkedList
   include Enumerable
  def initialize
    @sentinel_head=Node.new("head", nil)
    @sentinel_tail=Node.new("tail", nil)

    @sentinel_head.prev=nil
    @sentinel_head.next=@sentinel_tail
    @sentinel_tail.prev=@sentinel_head
    @sentinel_tail.next=nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sentinel_head.next
  end

  def last
    @sentinel_tail.prev
  end

  def empty?
     @sentinel_head.next == @sentinel_tail
  end

  def get(key)
    self.each do |node|
      return node.val if node.key==key
    end
    return nil
  end

  def include?(key)
    self.each do |node|
      return true if node.key==key
    end
    false
  end

  def append(key, val)
    new_node=Node.new(key,val)
    tails_tail_old=@sentinel_tail.prev
    @sentinel_tail.prev.next=new_node
    @sentinel_tail.prev=new_node

    new_node.next=@sentinel_tail
    new_node.prev=tails_tail_old
  end

  def update(key, val)
    self.each do |node|
      node.val=val if node.key==key
    end
  end

  def remove(key)
    self.each do |node|
      node.remove if node.key==key
    end
  end

  def each
    currentnode=@sentinel_head
    while(currentnode.next!=@sentinel_tail)
      currentnode=currentnode.next
      yield(currentnode)
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
