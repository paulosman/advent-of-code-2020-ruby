# FBFBBFFRLR
# first 7 chars specify F or B
# represent 128 rows (0-127)
# F: 0-63
# B: 32 - 63
# F: 32 - 47
# B: 40 - 47
# B: 44 - 47
# F: 44 - 45
# F: 44
# last 3 chars are L or R
# one of 8 columns
# 0 - 7
# R: 4 - 7
# L: 4 - 5
# R: 5
# So we're in 44-5
# Seat ID = row * 8 + col

def read_file(filename)
  File.open(filename).readlines()
end

def find_direction(directions, search_range)
  directions.each do |direction|
    middle = search_range.length / 2
    if direction == 'F' or direction == 'L'
      search_range = search_range[0..(middle-1)]
    elsif direction == 'B' or direction == 'R'
      search_range = search_range[middle..(search_range.length-1)]
    end
  end
  search_range.first
end

def seat_id(code)
  row = find_direction(code[0...7].split(''), (0..127).to_a)
  col = find_direction(code[7...10].split(''), (0..7).to_a)
  row * 8 + col
end

seat_ids = read_file('input.txt').map { |c| seat_id(c) }
min_seat_id = seat_ids.min
max_seat_id = seat_ids.max

min_seat_id.upto(max_seat_id) do |id|
  unless seat_ids.include? id
    if seat_ids.include?(id - 1) && seat_ids.include?(id + 1)
      puts("Found it: #{id}")
    end
  end
end

