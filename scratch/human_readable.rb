class Integer
  def human_readable
    n = self
    prefixes = ['', 'K', 'M', 'G', 'T']
    c = 0
    until n / 1024.0 < 1.0
      n /= 1024.0
      c += 1
    end
    "#{n.round(2)} #{prefixes[c]}B"
  end
  gir
end




10.times do
n=rand(1000000000)
puts "#{n.human_readable} = #{n.human_readable_pwr}?"
puts n.human_readable == n.human_readable_pwr
end