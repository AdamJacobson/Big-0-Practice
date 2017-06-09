class MinMaxStack
  def initialize
    @store = []
  end

  def max
    @store.last[:max] unless empty?
  end

  def min
    @store.last[:min] unless empty?
  end

  def peek
    @store.last[:value] unless empty?
  end

  def pop
    @store.pop[:value] unless empty?
  end

  def push(value)
    @store.push(value: value, min: new_min(value), max: new_max(value))
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

  private

  def new_max(val)
    empty? ? val : [max, val].max
  end

  def new_min(val)
    empty? ? val : [min, val].min
  end
end
