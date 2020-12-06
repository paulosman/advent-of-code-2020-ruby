def read_file(filename)
  File.open(filename).read.split("\n\n")
end

# Part One
sums = []

read_file('input.txt').each do |group|
  group = group.split('').filter{|c| c != "\n"}.uniq.join('')
  sums << group.length
end

puts(sums.sum)

# Part Two
sums = []
read_file('input.txt').each do |group|
  letters = Hash[('a'..'z').map { |c| [c, 0] }]
  people = group.split("\n")
  people.each do |person|
    person.split('').each do |answer|
      letters[answer] += 1
    end
  end
  
  yes = []
  letters.each do |k, v|
    if v == people.length
      yes << k
    end
  end

  sums << yes.length
  
end

puts sums.sum