Policy = Struct.new(:position_one, :position_two, :character) do
  def self.from_string(s)
    matches = s.match(/(\d+)-(\d+) (.*)/)
    Policy.new(matches[1].to_i, matches[2].to_i, matches[3])
  end
end

Password = Struct.new(:password, :policy) do
  def self.from_string(s)
    parts = s.split(':').map(&:strip)
    Password.new(parts[1], Policy.from_string(parts[0]))
  end
end

def get_passwords
  lines = File.open('input.txt').readlines()
  lines.map { |l| Password.from_string(l) }
end

def is_valid(password, policy)
  count = password.split('').count(policy.character)
  count >= policy.position_one && count <= policy.position_two
end

def is_valid_two(password, policy)
  first = password[policy.position_one - 1] == policy.character
  second = password[policy.position_two - 1] == policy.character
  first ^ second
end

def valid_passwords(&validator)
  validated = get_passwords.map { |password| validator.call(password) }
  validated.count(true)
end

puts valid_passwords { |p| is_valid(p.password, p.policy) }
puts valid_passwords { |p| is_valid_two(p.password, p.policy) }