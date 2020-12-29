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
end