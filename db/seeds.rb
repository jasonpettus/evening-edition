# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(email: 'test', password: '123456')

default_section = Section.create!(title: 'Default', user: user)

File.foreach('db/defaultfeeds.txt').each_slice(3) do |feed|
  p feed[0]
  sub = default_section.subscriptions.create(name: feed[0].chomp, assign_feed: feed[1].chomp)
end

default_section.cluster_similar_stories
