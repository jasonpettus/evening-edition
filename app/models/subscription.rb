require 'open-uri'
require 'mechanize'
require 'net/http'

class Subscription < ActiveRecord::Base
	has_many		:articles, dependent: :destroy
	has_many	:recent_articles, -> { order("created_at DESC").limit(5) }, class_name: 'Article'
	has_one		:user, through: :section
	belongs_to 	:section
end
