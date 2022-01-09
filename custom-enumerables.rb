require 'pry-byebug'

module Enumerable
  
  def my_each
    i = 0
    for i in 0..(self.length-1) do
      yield self[i]
    end
  end

  def my_each_with_index
    i = 0
    for i in 0..(self.length-1) do
        yield self[i], i
    end
  end

  def my_select
    choosen_items = []
    i = 0
    for i in 0..(self.length-1) do 
      if (yield self[i])
        choosen_items << self[i]
      end
    end
    return choosen_items
  end

  def my_all?
    true_items = []
    i = 0
    for i in 0..(self.length-1) do 
      if (yield self[i])
        true_items << self[i]
      end
    end
    if true_items.count == self.count
      return true
    else
      return false
    end
  end

  def my_any?
    true_items = []
    i = 0
    for i in 0..(self.length-1) do 
      if (yield self[i])
        true_items << self[i]
      end
    end
    if true_items.count > 0
      return true
    else
      return false
    end
  end

  def my_none?
    true_items = []
    i = 0
    for i in 0..(self.length-1) do 
      if (yield self[i])
        true_items << self[i]
      end
    end
    if true_items.count == 0
      return true
    else
      return false
    end
  end

  NO_ARGUMENT = Object.new
  def my_count(value = NO_ARGUMENT)
    if value == NO_ARGUMENT
      return self.length
    else
      counter = 0
      i = 0
      for i in 0..(self.length-1) do
        if self[i] == value
          counter += 1
        end
      end
      return counter
    end
  end

  def my_map
    new_array = []
    i = 0
    for i in 0..(self.length-1) do
      new_item = yield self[i]
      new_array << new_item
    end
    return new_array
  end

  def my_map_proc
    a_proc = Proc.new {|item| item * 2}
    new_array = []
    i = 0
    for i in 0..(self.length-1) do
      new_item = a_proc.call(self[i])
      new_array << new_item
    end
    return new_array
  end

  def my_map_proc_block(&my_block)
      a_proc = Proc.new {|item| item * 2}
      new_array = []
      i = 0
    if my_block
      self.my_each do
        new_item = my_block.call(self[i])
        new_array << new_item
        i+=1
      end
    else
      self.my_each do
        new_item = a_proc.call(self[i])
        new_array << new_item
        i+=1
      end
    end
      return new_array
  end

  def my_inject(default = 0)
    accumulator = default.clone
    i = 0
    self.my_each do
      accumulator = yield accumulator, self[i]
      i+=1
    end
    return accumulator
  end

  def multiply_els
    self.my_inject(1) {|accumulator, num| accumulator * num}
  end

end


#####TESTING BELOW#####

# #Test for my_each method
# puts "my_each vs. each"
# numbers = [1, 2, 3, 4, 5]
# numbers.my_each  { |item| puts item }
# numbers.each  { |item| puts item }

# #Test for my_each_with_index method
# puts "my_each_with_index vs. each_with_index"
# numbers = [1, 2, 3, 4, 5]
# numbers.my_each_with_index  { |item, key| puts "Index: #{key}  Item: #{item}"}
# numbers.each_with_index  { |item, key| puts "Index: #{key}  Item: #{item}" }

# #Test for my_select method
# puts "my_select vs. select"
# numbers = [1, 2, 3, 4, 5]
# p numbers.my_select  { |item| item != 3 }
# p numbers.select { |item| item != 3 }

# #Test for my_all? method
# puts "my_all? vs. all?"
# numbers = [1, 2, 3, 4, 5]
# p numbers.my_all?  { |item| item != 4 }
# p numbers.all? { |item| item != 4 }
# p numbers.my_all?  { |item| item != 6 }
# p numbers.all? { |item| item != 6 }

# #Test for my_any? method
# puts "my_any? vs. any?"
# numbers = [1, 2, 3, 4, 5]
# p numbers.my_any?  { |item| item == 4 }
# p numbers.any? { |item| item == 4 }
# p numbers.my_any?  { |item| item == 6 }
# p numbers.any? { |item| item == 6 }

# #Test for my_none? method
# puts "my_none? vs. none?"
# numbers = [1, 2, 3, 4, 5]
# p numbers.my_none?  { |item| item == 4 }
# p numbers.none? { |item| item == 4 }
# p numbers.my_none?  { |item| item == 6 }
# p numbers.none? { |item| item == 6 }

# #Test for my_count method
# puts "my_count vs. count"
# numbers = [1, 2, 3, 4, 5, nil, nil]
# p numbers.my_count
# p numbers.count
# p numbers.my_count(1)
# p numbers.count(1)
# p numbers.my_count(nil)
# p numbers.count(nil)

# #Test for my_map method
# puts "my_map vs. map"
# numbers = [1, 2, 3, 4, 5]
# p numbers.my_map  { |item| item * 2 }
# p numbers.map  { |item| item * 2 }

# #Test for my_inject method
# puts 'my_inject vs. inject'
# numbers = [1, 2, 3, 4, 5]
# p numbers.my_inject { |accumulator, num| accumulator + num}
# p numbers.inject { |accumulator, num| accumulator + num}

# #Test for my_inject method
# puts 'multiply_els to test my_inject'
# numbers = [1, 2, 3, 4, 5]
# p numbers.multiply_els

# #Test for my_map_proc method
# puts "my_map_proc vs. map"
# numbers = [1, 2, 3, 4, 5]
# p numbers.my_map_proc  { |item| item * 2 }
# p numbers.map  { |item| item * 2 }

# #Test for my_map_proc_block method
# puts "my_map_proc_block vs. map"
# numbers = [1, 2, 3, 4, 5]
# p numbers.my_map_proc_block 
# p numbers.my_map_proc_block { |item| item * 2 }
# p numbers.map  { |item| item * 2 }