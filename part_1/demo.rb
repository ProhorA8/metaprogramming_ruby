require 'oj'
require_relative 'album'
require_relative 'group'

album_data = File.read('./data/album.json')
group_data = File.read('./data/group.json')

puts Oj.load(album_data)
puts Oj.load(group_data)
