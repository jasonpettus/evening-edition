# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

default_section = Section.new(title: Default)

default_section.subscriptions.build(set_feed: 'http://america.aljazeera.com/content/ajam/articles.rss', title: 'Al Jazeera America')
default_section.subscriptions.build(set_feed: 'http://feeds.bbci.co.uk/news/rss.xml', title: 'BBC Top Stories')
default_section.subscriptions.build(set_feed: 'http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml', title: 'NYTimes US')

