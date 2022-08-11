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
  return n==1? 0 : 
    n==2? 1 : fib(n-1) + fib(n-2)
end
=begin#if(n==1)
return 0
end
if n%2 == 0
  return 1 + collatz(n/2)

end
if(n%2!=0)
  return 1 + collatz(3*n+1)
end
=end

def collatz(n)
  
return n==1? 0:
       n%2==0? 1 + collatz(n/2):
       n%2!=0? 1 + collatz(3*n+1):null
end  

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    if (block_given?)
      for value in self
        yield(value)
      end
    end
    self
  end
end
