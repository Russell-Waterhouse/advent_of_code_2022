require 'set'


class Rucksack
  
  def initialize(input)
    input_len = input.length
    raise Exception.new "input not even <#{input}>" if input_len % 2 != 0

    first_half = input.slice(0, input_len / 2).split("")
    second_half = input.slice(input_len / 2, input_len / 2).split("")
    @compartment1 = first_half.to_set
    @compartment2 = second_half.to_set
  end

  def everything()
    @compartment1 + @compartment2
  end

  def compartment1()
    @compartment1
  end


  def compartment2()
    @compartment2
  end

  def intersection()
    @compartment1 & @compartment2
  end
end


def letter_to_priority(letter)
  ascii_val = letter.ord
  case ascii_val
  when 97..122 # lowercase letters
    ascii_val - 96
  when 65..90  # uppercase letters
    ascii_val - 65 + 27
  else
    raise Exception.new "character <#{letter} out of expected range"
  end 
end

rucksack_data = IO.readlines(ARGV[0])
puts "input line number #{rucksack_data.length}"
rucksacks = []
rucksack_data.each do |line|
  line = line.sub("\n", "")
  rucksacks.append(Rucksack.new(line))
end

puts "rucksacks number #{rucksacks.length}"
intersections = []
rucksacks.each do |ruck|
  intersections.append(ruck.intersection)
end

priority_total = 0
puts "intersections number #{intersections.length}"
intersections.each do |intersecting_set|
  intersecting_set.each do |letter|
    priority_total += letter_to_priority letter
  end
end

puts priority_total


##############################################
############ Part 2 ##########################
##############################################


class ElfGroup

  def initialize(ruck1, ruck2, ruck3)
    @ruck1 = ruck1
    @ruck2 = ruck2
    @ruck3 = ruck3
  end

  def get_badge()
    @ruck1.everything & @ruck2.everything & @ruck3.everything
  end
end

i = 0
groups = []
while i + 3 <= rucksack_data.length
  groups.append(ElfGroup.new(
                 Rucksack.new(rucksack_data[i].sub("\n", "")),
                 Rucksack.new(rucksack_data[i + 1].sub("\n", "")),
                 Rucksack.new(rucksack_data[i + 2].sub("\n", ""))
  ))
  i += 3
end

badge_sets = []
groups.each do |group|
  badge_sets.append(group.get_badge)
end

total_badge_priority = 0
badge_sets.each do |badge_set|
  badge_set.each do |badge|
    total_badge_priority += letter_to_priority badge
  end
end

puts "Total badge priority: "
puts total_badge_priority 

