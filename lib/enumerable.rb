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
end