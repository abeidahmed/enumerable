module Enumerable
  def my_each
    idx = 0

    arr ||= self.to_a
    while idx < arr.length
      yield(arr[idx])
      idx += 1
    end

    arr
  end

  def my_each_with_index
    idx = 0

    while idx < self.length
      yield(self[idx], idx)
      idx += 1
    end

    self
  end

  def my_select
    arr = []

    my_each do |n|
      arr << n if yield(n)
    end

    arr
  end

  def my_all?(arg = nil, &block)
    if arg
      my_each { |ele| return false unless arg === ele } # rubocop:disable Style/CaseEquality
    elsif block_given?
      my_each { |ele| return false unless yield(ele) }
    else
      my_each { |ele| return false unless ele }
    end

    true
  end

  def my_map(proc = nil)
    arr = []

    if proc
      my_each { |ele| arr << proc.call(ele) }
    else
      my_each { |ele| arr << yield(ele) }
    end

    arr
  end

  def my_any?(arg = nil, &block)
    if arg
      my_each { |ele| return true if arg === ele } # rubocop:disable Style/CaseEquality
    elsif block_given?
      my_each { |ele| return true if yield(ele) }
    else
      my_each { |ele| return true if ele }
    end

    false
  end

  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
  end

  def my_count(arg = nil)
    count = 0

    if block_given?
      my_each { |ele| count += 1 if yield(ele) }
    elsif arg
      my_each { |ele| count += 1 if ele == arg }
    else
      count = self.size
    end

    count
  end

  def my_inject(*args)
    init = args.size.positive?
    memo = init ? args.first : self.to_a.first
    drop(init ? 0 : 1).my_each { |ele| memo = yield(memo, ele) }
    memo
  end
end