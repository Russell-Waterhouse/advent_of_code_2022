
return unless ARGV.length > 0

def make_array(foods)
  arr = Array.new
  arr.push(0)
  elf_num = 0 
  foods.each do |f| 
    if f == "\n" 
      elf_num += 1
      arr.push(0)
    else
      arr[elf_num] += f.to_i
    end
  end
  arr
end


in_arr = IO.readlines(ARGV[0])
a = make_array(in_arr)
i = 0 
i_max = 0

while i < a.length
  if a[i] > a[i_max]
    i_max = i
  end
  i += 1
end

puts "The elf with the most calories is elf #{i_max + 1} with #{a[i_max]} calories"
