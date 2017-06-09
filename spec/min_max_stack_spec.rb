require 'rspec'
require 'min_max_stack'

describe MinMaxStack do
  subject(:stack) { MinMaxStack.new }
  context "#new" do
    it "initializes with an empty store" do
      expect(stack.empty?).to be(true)
    end
  end

  context "#peek" do
    it "returns the last value pushed" do
      stack.push(1)
      stack.push(2)
      stack.push(3)
      expect(stack.peek).to eq(3)
    end
  end

  context "#push" do
    it "adds the value to the stack" do
      stack.push(1)
      expect(stack.empty?).to be(false)
      expect(stack.peek).to eq(1)
    end
  end

  context "#pop" do
    it "removes the top element and returns it" do
      stack.push(1)
      stack.push(2)
      stack.push(3)
      expect(stack.pop).to eq(3)
      expect(stack.size).to eq(2)
      expect(stack.peek).to eq(2)
    end
  end

  context "#max" do
    context "after pushing a new max" do
      it "max value of the stack is the new max" do
        stack.push(1)
        expect(stack.max).to eq(1)
        stack.push(4)
        expect(stack.max).to eq(4)
      end
    end

    context "#after removing the current max" do
      it "max value of the stack is the previous max" do
        stack.push(1)
        stack.push(4)
        stack.pop
        expect(stack.max).to eq(1)
      end
    end
  end

  context "#min" do
    context "after pushing a new min" do
      it "min value of the stack is the min max" do
        stack.push(3)
        expect(stack.min).to eq(3)
        stack.push(1)
        expect(stack.min).to eq(1)
      end
    end

    context "#after removing the current min" do
      it "min value of the stack is the previous min" do
        stack.push(3)
        stack.push(1)
        stack.pop
        expect(stack.min).to eq(3)
      end
    end
  end
end
