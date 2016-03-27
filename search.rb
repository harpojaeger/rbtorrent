require 'rubygems'
require 'httparty'
require 'open-uri'
require 'open_uri_redirections'
require 'yaml'

# Define a Torrent class for making API calls.  h/t HTTParty http://www.railstips.org/blog/archives/2008/07/29/it-s-an-httparty-and-everyone-is-invited/
class Torrent
  include HTTParty
  format:xml
  def self.search(q)
    get('https://torrentproject.se', query: { s: q, filter: 1101, out: 'rss' })
  end

  def self.download(url)
    uri = URI.parse(url)
    filename = File.basename(uri.path)
    torrent = ''
    uri.open(allow_redirections: :safe) do |f|
      f.each_line { |line| torrent += line }
    end

    f = File.new(filename, 'w')
    f.write(torrent)
    f.close
  end
end

# Method for making filesizes human readable
class Integer
  include Math
  def human_readable
    n = self
    pwr = log(n, 1024)
    prefixes = ['', 'K', 'M', 'G', 'T']
    pref = pwr.to_i
    factor = 1024.0**pref
    size = (n / factor).round(2)
    "#{size} #{prefixes[pref]}B"
  end
end

def load_options
  @options = YAML.load(File.read('config.yaml'))
  @options[:behavior] ||= 'loop'
  puts "using input-mode #{@options[:behavior]}"
end

def search(s)
  puts "#{s} torrent search results:"
  results = Torrent.search(s).parsed_response['rss']['channel']
  n = 1
  results['item'].each do |item|
    size = item['enclosure']['length'].to_i.human_readable
    description = item['description']

    puts "(#{n}) #{item['title']} #{size}"
    n += 1
  end

  print 'Download #'
  num = gets.chomp.to_i
  if num > 0
    selected = results['item'][num - 1]
    url = selected['enclosure']['url']
    Torrent.download(url)
  end
end

load_options
s = TRUE

while s && @options[:behavior] == 'loop'
  print 'Search: '
  s = gets.chomp

  search(s) unless s.empty?
  s = false if s.empty?
end

if @options[:behavior] == 'file'
  File.foreach(@options[:inputfile]) { |x| search(x.strip) unless x.empty? }
end
