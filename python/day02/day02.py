import re

class Policy(object):
    def __init__(self, s):
        p = re.compile(r'(\d+)-(\d+) (.*)')
        groups = p.match(s).groups()
        if len(groups) != 3:
            raise Exception("Invalid policy string")
        self.position_one = int(groups[0])
        self.position_two = int(groups[1])
        self.character = groups[2]

class Password(object):
    def __init__(self, value, policy):
        self.value = value
        self.policy = policy
    
    def is_valid_one(self):
        count = list(self.value).count(self.policy.character)
        return count >= self.policy.position_one and count <= self.policy.position_two

    def is_valid_two(self):
        first = self.value[self.policy.position_one - 1] == self.policy.character
        second = self.value[self.policy.position_two - 1] == self.policy.character
        return first ^ second

def read_passwords(filename):
    fp = open(filename, 'r')
    lines = fp.readlines()
    fp.close()
    parts = list(map(lambda s: list(map(lambda c: c.strip(), s.split(":"))), lines))
    return [Password(p[1], Policy(p[0])) for p in parts]

print(len(list(filter(lambda p: p.is_valid_one(), read_passwords('input.txt')))))
print(len(list(filter(lambda p: p.is_valid_two(), read_passwords('input.txt')))))