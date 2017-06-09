

class StackQueue
  attr_reader :in_queue, :out_queue

  def initialize
    @out_queue = MyStack.new
    @in_queue = MyStack.new
    @min_stack = MyStack.new
    @max_stack = MyStack.new

    @last_added = nil
  end

  def enqueue(elem)
    if @last_added.nil?
      new_entry = { val: elem, max: elem, min: elem }
    else
      new_max = @last_added[:max] > elem ? @last_added[:max] : elem
      new_min = @last_added[:min] < elem ? @last_added[:min] : elem
      new_entry = { val: elem, max: new_max, min: new_min }
    end

    @in_queue.push(new_entry)
    @last_added = new_entry
  end

  def dequeue
    if @out_queue.empty?
      until @in_queue.empty?
        @out_queue.push(@in_queue.pop)
      end
    end

    @out_queue.pop
  end

  def max
    @last_added[:max]
  end

  def min
    @last_added[:min]
  end

  def peek
    @last_added
  end

  def empty?
    @out_queue.empty? && @in_queue.empty?
  end

  def size
    @out_queue.length + @in_queue.length
  end
end

class MyStack
  def initialize
    # @max = []
    # @min = []
    @store = []
  end

  def max
    @max.last
  end

  def min
    @min.last
  end

  def push(elem)
    # @max << elem if @max.empty? || elem >= @max.last
    # @min << elem if @min.empty? || elem <= @min.last
    @store.push(elem)
  end

  def pop
    popped = @store.pop
    # @max.pop if @max.last == popped
    # @min.pop if @min.last == popped
    popped
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

# n ^ 2
def bad_windowed_range(arr, window_size)
  current_max = nil

  arr.each_index do |idx|
    window = arr.slice(idx, window_size)
    max = window.max
    min = window.min
    new_max = max - min
    current_max = new_max if current_max.nil? || new_max > current_max
  end

  current_max
end

def good_windowed_range(arr, window_size)
  stack_queue = StackQueue.new

  window_size.times do
    stack_queue.enqueue(arr.shift)
  end

  puts "Max is #{stack_queue.max}"
  puts "Min is #{stack_queue.min}"
  puts "Out is #{stack_queue.out_queue.inspect}"
  puts "In is #{stack_queue.in_queue.inspect}"

  max_range = stack_queue.max - stack_queue.min

  arr.each do |val|
    stack_queue.dequeue
    stack_queue.enqueue(val)

    puts "Max is #{stack_queue.max}"
    puts "Min is #{stack_queue.min}"
    puts "Out is #{stack_queue.out_queue.inspect}"
    puts "In is #{stack_queue.in_queue.inspect}"
    p "------"

    new_max_range = stack_queue.max - stack_queue.min
    max_range = new_max_range if new_max_range > max_range
  end

  max_range
end

p good_windowed_range([1, 0, 2, 10], 2) #== 4 # 4, 8
# p good_windowed_range([1, 0, 5, 2], 2) #== 4 # 4, 8
# p good_windowed_range([1, 0, 2, 5, 4, 8], 2) #== 4 # 4, 8
# p good_windowed_range([1, 0, 2, 5, 4, 8], 3) #== 5 # 0, 2, 5
# p good_windowed_range([1, 0, 2, 5, 4, 8], 4) #== 6 # 2, 5, 4, 8
# p good_windowed_range([1, 3, 2, 5, 4, 8], 5) #== 6 # 3, 2, 5, 4, 8
