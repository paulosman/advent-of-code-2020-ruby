def read_file(filename):
    """Read file, converting each line into an integer"""
    fp = open(filename, 'r')
    lines = fp.readlines()
    fp.close()
    return list(map(lambda l: int(l.strip()), lines))

def find_two(numbers, sumval):
    """Find two numbers in numbers that sum to sumval."""
    seen = {}
    for number in numbers:
        needed = sumval - number
        if needed in seen:
            return (number, needed)
        else:
            seen[number] = True
    return ()

def find_three(numbers, sumval):
    """Find three numbers in numbers that sum to sumval."""
    seen = {}
    for number in numbers:
        needed = sumval - number
        seen[number] = needed
        attempt = find_two(numbers, needed)
        if len(attempt) == 2:
            return (attempt[0], attempt[1], number)
    return ()

input = read_file('input.txt')

# Part one
result = find_two(input, 2020)
if len(result) == 2:
    print(result[0] * result[1])

# Part two
result = find_three(input, 2020)
if len(result) == 3:
    print(result[0] * result[1] * result[2])