def part_one
  seen = {}
  numbers = File.new('input.txt').readlines.map(&:to_i)
  solution = find_two(numbers, 2020)
  puts(solution[0] * solution[1])
end

def find_two(l, sum)
  seen = {}
  l.each do |n|
    needed = sum - n
    if seen.key? needed
      return [needed, n]
    else
      seen[n] = 1
    end
  end
  return []
end

def part_two
  seen = {}
  lines = File.new('input.txt').readlines.map(&:to_i)
  sorted = lines.sort
  0.upto(sorted.length - 2).each do |i|
    needed = 2020 - (sorted[i] + sorted[i + 1])
    sorted.each do |n|
      if n == needed
        puts(sorted[i] * sorted[i + 1] * needed)
      end
    end
  end
end

part_two
