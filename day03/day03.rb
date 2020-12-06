def read_file(filename)
  File.open(filename).readlines.map(&:strip).map { |l| l.split("") }
end

def navigate(lines, across_step, down_step)
  down = across = trees = 0
  while down < lines.length - 1
    across += across_step
    down += down_step
    trees += 1 if lines[down][across % lines[0].length] == '#'
  end
  trees
end

lines = read_file('input.txt')

# Part one
puts(navigate(lines, 3, 1))

# Part two
puts(navigate(lines, 1, 1) *
     navigate(lines, 3, 1) *
     navigate(lines, 5, 1) *
     navigate(lines, 7, 1) *
     navigate(lines, 1, 2))