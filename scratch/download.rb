require 'open-uri'
require 'open_uri_redirections'

url="http://torrentproject.se/torrent/EB814B0E02EB24EC9A9CAF6EA54F7B12E06F9BFA.torrent"
uri = URI.parse(url)
filename = File.basename(uri.path)
torrent=""
uri.open(:allow_redirections => :safe){|f|
f.each_line {|line| torrent += line}
}


f=File.new(filename,'w')
f.write(torrent)
f.close