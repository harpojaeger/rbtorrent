require 'id3tag'
mp3_file = File.open('/Users/harpojaeger/Music/iTunes/iTunes Music/AC_DC/Back In Black/1-01 Hells Bells.m4a', "rb")
tag = ID3Tag.read(mp3_file)
puts tag.frames