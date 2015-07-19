# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

default_section = Section.create!(title: 'Default9')

default_section.subscriptions.create(set_feed: 'http://america.aljazeera.com/content/ajam/articles.rss', name: 'Al Jazeera America')
# default_section.subscriptions.create!(set_feed: 'http://feeds.bbci.co.uk/news/rss.xml', name: 'BBC Top Stories')
default_section.subscriptions.create!(set_feed: 'http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml', name: 'NYTimes US')

