require 'nokogiri'
=begin
class Track

  @@albums = {}
  attr_accessor :title
  attr_accessor :artist

  def initialize(title,artist)
    @title = title
    @artist = artist
    @@albums[id] = self
  end
  
  def Album.get_albums
    @@albums
  end
end
=end
artists = {}
loc="/Users/harpojaeger/Music/iTunes/iTunes Library.xml"
	
doc = File.open(loc) { |f| Nokogiri::XML(f) }
 
tracks = doc.xpath('/plist/dict/dict/dict')
tracks.each do |track|

artist = track.xpath("key[text()='Artist']/following::string[1]").text
album_artist = track.xpath("key[text()='Album Artist']/following::string[1]").text
album = track.xpath("key[text()='Album']/following::string[1]").text
artist = album_artist unless album_artist == ""
artists[artist] ||= []
artists[artist].push(album) unless artists[artist].include?(album)

end
artists = artists.sort_by {|artist, album| artist}
