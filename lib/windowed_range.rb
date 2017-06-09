require_relative 'min_max_stack'

class StackQueue
  attr_reader :in_stack, :out_stack

  def initialize
    @out_stack = MinMaxStack.new
    @in_stack = MinMaxStack.new
  end

  def enqueue(elem)
    @in_stack.push(elem)
  end

  def dequeue
    shift_stacks if @out_stack.empty?
    @out_stack.pop
  end

  def max
    maxes = []
    maxes << @in_stack.max unless @in_stack.empty?
    maxes << @out_stack.max unless @out_stack.empty?
    maxes.max
  end

  def min
    mins = []
    mins << @in_stack.min unless @in_stack.empty?
    mins << @out_stack.min unless @out_stack.empty?
    mins.min
  end

  def empty?
    @out_stack.empty? && @in_stack.empty?
  end

  def size
    @out_stack.size + @in_stack.size
  end

  private

  def shift_stacks
    @out_stack.push(@in_stack.pop) until @in_stack.empty?
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

  # puts "Max is #{stack_queue.max}"
  # puts "Min is #{stack_queue.min}"
  # puts "Out is #{stack_queue.out_queue.inspect}"
  # puts "In is #{stack_queue.in_queue.inspect}"

  max_range = stack_queue.max - stack_queue.min

  arr.each do |val|
    stack_queue.dequeue
    stack_queue.enqueue(val)
    #
    # puts "Max is #{stack_queue.max}"
    # puts "Min is #{stack_queue.min}"
    # puts "Out is #{stack_queue.out_queue.inspect}"
    # puts "In is #{stack_queue.in_queue.inspect}"
    # p "------"

    new_max_range = stack_queue.max - stack_queue.min
    max_range = new_max_range if new_max_range > max_range
  end

  max_range
end

p good_windowed_range([1, 0, 2, 10], 2) #== 4 # 4, 8
p good_windowed_range([1, 0, 5, 2], 2) #== 4 # 4, 8
p good_windowed_range([1, 0, 2, 5, 4, 8], 2) #== 4 # 4, 8
p good_windowed_range([1, 0, 2, 5, 4, 8], 3) #== 5 # 0, 2, 5
p good_windowed_range([1, 0, 2, 5, 4, 8], 4) #== 6 # 2, 5, 4, 8
p good_windowed_range([1, 3, 2, 5, 4, 8], 5) #== 6 # 3, 2, 5, 4, 8
