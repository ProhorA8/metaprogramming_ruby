require 'oj'
require_relative 'album'
require_relative 'group'

album_data = File.read('./data/album.json')
group_data = File.read('./data/group.json')

album = Album.new

# первый подход
# обходим хэш
# Oj.load(album_data).each do |method, value|
#   # выполняем присваивание методу
#   album.send "#{method}=", value
# end

# второй подход
Oj.load(album_data).each do |method, value|
  # заполняем значения переменных образца класса
  album.instance_variable_set :"@#{method}", value
end

puts album.inspect #=> #<Album:0x00007fc3ca912090 @title="Ride the Lightning",
# @group="Metallica", @year=1984, @label="Megaforce Records", @length="00:47:25", @tracks_count=10>
