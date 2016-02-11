require 'rubygems'
require 'httparty'
require 'open-uri'
require 'open_uri_redirections'

# Define a Torrent class for making API calls.  h/t HTTParty http://www.railstips.org/blog/archives/2008/07/29/it-s-an-httparty-and-everyone-is-invited/
class Torrent
  include HTTParty
  format:xml
  def self.search(q)
    get('https://torrentproject.se', query: { s: q, filter: 1101, out: 'rss' })
  end
end

# Method for making filesizes human readable
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
end

s = 'David Bowie Ziggy Stardust'
results = Torrent.search(s).parsed_response['rss']['channel']
n = 1
results['item'].each do |item|
  size = item['enclosure']['length'].to_i.human_readable
  puts "(#{n}) #{item['title']} #{size}"
  n += 1
end
p

print 'Download #'
num = gets.chomp.to_i
selected = results['item'][num - 1]
url = selected['enclosure']['url']

uri = URI.parse(url)
filename = File.basename(uri.path)
torrent = ''
uri.open(:allow_redirections => :safe) do |f|
  f.each_line { |line| torrent += line }
end

f = File.new(filename, 'w')
f.write(torrent)
f.close
