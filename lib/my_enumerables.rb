module Enumerable
  def my_each_with_index
    index = 0
    proc =
      Proc.new do |value|
        yield(value, index)
        index += 1
      end

    my_each(&proc)
    return self
  end

  def my_select
    arr = Array.new
    proc = Proc.new { |value| arr.push(value) if (yield(value)) }
    my_each(&proc)

    arr
  end

  def my_all?
    ret = true
    proc = Proc.new { |value| ret = ret && yield(value) }
    my_each(&proc)
    ret
  end
  def my_any?
    ret = false
    proc = Proc.new { |value| ret = ret || yield(value) }
    my_each(&proc)

    ret
  end
  def my_none?
    ret = true
    proc = Proc.new { |value| ret = ret && !yield(value) }
    my_each(&proc)
    ret
  end

  def my_count
    return self.length unless (block_given?)
    count = 0
    proc = Proc.new { |value| count += 1 if yield(value) }
    my_each(&proc)

    return count
  end
  def my_map
    return self unless (block_given?)

    arr = Array.new()

    proc = Proc.new { |value| arr.push(yield(value)) }

    my_each(&proc)

    return arr
  end
end

def fib(n)
  return n == 1 ? 0 : n == 2 ? 1 : fib(n - 1) + fib(n - 2)
end

def collatz(n)
  return(
    n == 1 ?
      0 :
      n % 2 == 0 ?
        1 + collatz(n / 2) :
        n % 2 != 0 ? 1 + collatz(3 * n + 1) : null
  )
end

def palindromes_recursive(word)
  return(
    (
      if word.size <= 1
        true
      else
        word[0] === word[-1] && palindromes_recursive(word[1..-2])
      end
    )
  )
end

def bottles(n)
  if (n == 0)
    puts "no more bottles of beer on the wall"
  else
    puts "#{n} bottles of beer on the wall"
    bottles(n - 1)
  end
end

def array_flattener(arr)
  return [] << arr if !arr.kind_of?(Array)

  return(
    (
      if arr.length > 1
        (array_flattener(arr.shift()) + array_flattener(arr))
      else
        array_flattener(arr.shift())
      end
    )
  )
end

array_flattener(
  [
    { name: 5, number: 6, yes: 9 },
    [1, 2],
    [3, 4],
    [[1, [8, 9]], [3, 4]],
    [[[]]]
  ]
)

def flatten2(arr, result = [])
  for value in arr
    value.kind_of?(Array) ? flatten2(value, result) : result << value
  end
  result
end

flatten2(
  [
    { name: 5, number: 6, yes: 9 },
    [1, 2],
    [3, 4],
    [[1, [8, 9]], [3, 4]],
    [[[]]]
  ]
)

# You will first have tgggo define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method

def merge(astart, aend, ret = [])
  (astart.length + aend.length).times do
    if aend.empty?
      return ret + astart
    elsif astart.empty?
      return ret + aend
    end

    astart[0] < aend[0] ? ret.push(astart.shift) : ret.push(aend.shift)
  end
  ret
end

def merge_sort(arr)
  return arr if (arr.length <= 1)

  arr_end = arr.slice(arr.length / 2..-1)
  arr_start = arr.slice(0..(arr.length / 2) - 1)

  arr_start = merge_sort(arr_start)
  arr_end = merge_sort(arr_end)

  return merge(arr_start, arr_end)
end

merge_sort([6, 4, 9, 10])
p merge_sort([99, 1, 125, 68_797_987, 1, 879_879, 6, 5, 8, 0])

def bubble_sort(arr)
  unsorted = true
  while unsorted
    unsorted = false
    for i in (0..arr.length - 2)
      if (arr[i] <=> arr[i + 1]) == 1
        unsorted = true

        arr[i], arr[i + 1] = arr[i + 1], arr[i]
      end
    end
  end
  return arr
end

p bubble_sort([4, 3, 1, 78, 2, 0, 2])

def bin_search(arr, item)
  iterations = 0
  not_found = true
  while not_found
    iterations += 1
    middle = (arr.length / 2.0).round - 1
    puts "#{iterations} interations and value is #{arr[middle]}"
    if (item <=> arr[middle]) == -1
      arr = arr[0..middle - 1] #Skips the middle as greatest value
    elsif (item <=> arr[middle]) == 1
      arr = arr[middle + 1..-1] #skips the middle as smallest value
    else
      not_found = false
    end
  end
  return iterations
end

puts bin_search(bubble_sort([4, 3, 1, 78, 2, 0, 2]), 0)
