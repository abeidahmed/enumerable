module Enumerable
  def my_each
    return enum_for unless block_given?

    idx = 0

    arr ||= to_a
    while idx < arr.length
      yield(arr[idx])
      idx += 1
    end

    arr
  end

  def my_each_with_index
    return enum_for unless block_given?

    idx = 0

    while idx < length
      yield(self[idx], idx)
      idx += 1
    end

    self
  end

  def my_select
    return enum_for unless block_given?

    arr = []

    my_each do |n|
      arr << n if yield(n)
    end

    arr
  end

  def my_all?(arg = nil)
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
    return enum_for unless block_given?

    arr = []

    if proc
      my_each { |ele| arr << proc.call(ele) }
    else
      my_each { |ele| arr << yield(ele) }
    end

    arr
  end

  def my_any?(arg = nil)
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
      count = size
    end

    count
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def my_inject(arg = nil, sym = nil)
    if (arg && sym.nil?) && (arg.is_a?(Symbol) || arg.is_a?(String))
      sym = arg
      arg = nil
    end

    if !block_given? && sym
      to_a.my_each { |item| arg = arg ? arg.send(sym, item) : item }
    else
      to_a.my_each { |item| arg = arg ? yield(arg, item) : item }
    end

    arg
  end

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
end
