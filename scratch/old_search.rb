require 'httparty'
require 'open-uri'



class String
  def is_integer?
    self.to_i.to_s == self
  end
end

def humanReadable(n)
prefixes=["","K","M","G","T"]
c=0
until n/1024 < 1.0
n = n/1024.0
c+=1
end
n=n.round(2)
return "#{n} #{prefixes[c]}B"
end

=begin
print "Artist:"
artist=gets.chomp
print "Album:"
album=gets.chomp
s="#{artist} #{album}"
=end
s="David Bowie"
baseurl = "https://torrentproject.se"
path    = ""
query   = URI.encode_www_form(
    "s" => s,
    "out" => "rss",
    "filter" => "1101",  
)
uri = URI("#{baseurl}#{path}?#{query}")

response = HTTParty.get(uri)
results=response.parsed_response
puts results
=begin
results.each do |k,v| puts "(#{k}) #{v['title']} #{humanReadable(v['torrent_size'])}" if k.is_integer? end
num=""
until num.is_integer?
print "Get hash for #"
num=gets.chomp
end
torrent_hash=results[num]["torrent_hash"]
puts torrent_hash
puts results[num]
=end




download_dir="/Users/harpojaeger/Downloads"
#full_path="#{download_dir}/#{torrent_hash}.torrent"




