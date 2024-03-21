def addition(n)
  l = n.length
  max = n[0]
  temp = 0
  for i in 0...l
    if n[i] > max
      temp = max
      max = n[i]
      n[i] = temp
    end
  end
  puts max
end
n = [4,5,23,51,1,9]
addition(n)
n.delete(51)
puts n.inspect
