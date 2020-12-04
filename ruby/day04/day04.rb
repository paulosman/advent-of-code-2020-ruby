Passport = Struct.new(:fields) do
  def required_fields?
    required_fields = [
      :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid
    ]
    required_fields.map { |field| fields.key? field.to_s }.all?
  end

  def valid_height?(height)
    if height =~ /^\d+cm$/
      height.to_i >= 150 && height.to_i <= 193
    elsif height =~ /^\d+in$/
      height.to_i >= 59 && height.to_i <= 76
    else
      false
    end
  end

  def valid?
    required_fields? &&
      fields['byr'].to_i >= 1920 && fields['byr'].to_i <= 2002 &&
      fields['iyr'].to_i >= 2010 && fields['iyr'].to_i <= 2020 &&
      fields['eyr'].to_i >= 2020 && fields['eyr'].to_i <= 2030 &&
      valid_height?(fields['hgt']) &&
      fields['hcl'] =~ /^#[0-9a-f]{6}$/ &&
      %w{amb blu brn gry grn hzl oth}.include?(fields['ecl']) &&
      fields['pid'] =~ /^\d{9}$/
  end
end

def read_passports(filename)
  passports = File.open(filename).read.split("\n\n")
  fields = passports.map { |passport| passport.gsub(/\s+/m, ' ').strip.split(' ') }
  fields.map { |f| Passport.new(Hash[f.map { |el| el.split(':') }]) }
end

puts(read_passports('input.txt').count { |p| p.valid? })