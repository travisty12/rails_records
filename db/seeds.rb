# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
album_list = [
  ["Kind Of Blue"],
  ["Giant Steps"],
  ["A Love Supreme"],
  ["Bitches Brew"],
  ["Back In Black"],
  ["Highway To Hell"],
  ["High Voltage"],
  ["Dirty Deeds Done Dirt Cheap"],
  ["Red Clay"],
  ["Because The Internet"]
]

album_list.each do |album_name|
  Album.create( name: album_name)
end