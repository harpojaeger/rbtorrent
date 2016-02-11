def bencodeS(s)
return "#{s.length}:#{s}"
end
def bencodeI(s)
return "i#{s}e"
end





def bencode(s)
case s
when String then return bencodeS(s)
when Integer then return bencodeI(s)
when Hash then
s.sort!
bencoded="d"
s.each do |k,v| bencoded+="#{k.length}:#{k}#{v.length}:#{v}"
bencoded+="e"
return bencoded
end
when Array then
bencoded="l"
s.each do |i| bencoded+="#{i.length}:#{i}"
return bencoded
end
end
end



puts bencode("spam")
puts bencode(3)
puts bencode(-3)
puts bencode(0)
puts bencode(["spam","eggs"])
puts bencode(Hash["cow"=>"moo","spam"=>"eggs"])