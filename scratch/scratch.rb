require 'open-uri'
require 'httparty'
def construct_magnet_link(hash,name,trackers)
link="magnet:?xt=urn:btih:#{hash}&"
link+=URI.encode_www_form(
"dn"=>name)
trackers.each do |tracker| link+="&#{URI.encode_www_form('tr'=>tracker)}" end
return link
end

def api_query(url)
puts url
response = HTTParty.get(url)
return response.parsed_response
end






torrent_hash="8ac3731ad4b039c05393b5404afa6e7397810b41"
trackers=api_query("https://torrentproject.se/#{torrent_hash}/trackers_json")
puts construct_magnet_link(torrent_hash,"David Bowie - Best Of Bowie (EMI Limited Edition) [FLAC]",trackers)





def api_query(url)
puts url
response = HTTParty.get(url)
return response.parsed_response
end

def construct_magnet_link(hash,name,trackers)
link="magnet:?xt=urn:btih:#{hash}"
puts URI.encode_www_form(
"dn"=>name)




end
