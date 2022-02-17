require_relative 'main'

album = Album.new('album')
group = Group.new('group')

puts album.inspect
puts group.inspect

puts '=' * 40

puts album.title
puts group.title
puts group.leader
