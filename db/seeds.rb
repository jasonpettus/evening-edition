# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
<<<<<<< Updated upstream
=======

default_section = Section.create!(title: 'Default20')

File.foreach('db/defaultfeeds.txt').each_slice(3) do |feed|
  p feed[0].chomp
  p feed[1].chomp
  default_section.subscriptions.create(name: feed[0].chomp, set_feed: feed[1].chomp)
end
>>>>>>> Stashed changes
