# Evening-Edition [![Build Status](https://travis-ci.org/jasonpettus/evening-edition.svg?branch=master)](https://travis-ci.org/jasonpettus/evening-edition) [![Coverage Status](https://coveralls.io/repos/jasonpettus/evening-edition/badge.svg?branch=master&service=github)](https://coveralls.io/github/jasonpettus/evening-edition?branch=master)

https://github.com/jasonpettus/evening-edition/tree/master/app/assets/images/eelogosmall.jpg

Love your RSS reader, but miss the elegance and visual heirarchy of a traditional newspaper? What about all those times when you get served up half a dozen versions of the same story? **Evening Edition** is a Rubyfied feed reader that addresses both of these concerns: designed to be read only once a day, it lays out its stories in a manner pleasing to the eye, with visual clues as to which events are being talked about the most; and it examines these stories long before you read them, grouping similar articles together so that you see only one version (with a button and drop-down menu that lets you see the rest).

Check out the public build at: http://evening-edition.herokuapp.com

## Screenshots

https://github.com/jasonpettus/evening-edition/tree/master/app/assets/images/eess1.png

https://github.com/jasonpettus/evening-edition/tree/master/app/assets/images/eess2.png

https://github.com/jasonpettus/evening-edition/tree/master/app/assets/images/eess3.png

https://github.com/jasonpettus/evening-edition/tree/master/app/assets/images/eess4.png

https://github.com/jasonpettus/evening-edition/tree/master/app/assets/images/eess5.png

## Requirements
- Ruby 2.0.0
- Rails 4.2.3
- PostgreSQL 9.3.5
- Internet access

## External APIs, Gems and Libraries

### [Material Design](http://www.google.com/design/spec/material-design/introduction.html)

Evening Edition uses a modified version of Material Design, the design language invented by Google for all their in-house and Android applications.

### [UglifyJS](https://github.com/mishoo/UglifyJS2)

A JavaScript parser, minifier and compressor.

### [jQuery](https://jquery.com/)

A JavaScript library for easy on-screen updates of content. Evening Edition also uses AJAX, a specialized section of jQuery.

### [Feedjira](http://feedjira.com/)

A Ruby gem for fetching and parsing RSS feeds. *Highly recommended.*

### [Nokogiri](http://www.nokogiri.org/)

A Ruby gem for parsing HTML documents.

### [FastImage](https://github.com/sdsykes/fastimage)

A Ruby gem for quickly finding an image based on its URI.

### [Kaminari](https://github.com/amatsuda/kaminari)

A Ruby gem for generating automated "pagination" links at the bottom of pages. *Highly recommended.*

### [Mechanize](https://github.com/sparklemotion/mechanize)

A Ruby library for automating interactions with websites.

### [HTMLEntities](https://github.com/threedaymonk/htmlentities)

A Ruby library for facilitating the encoding and decoding of named or numerical entities in HTML documents.

### [BCrypt](https://github.com/codahale/bcrypt-ruby)

A Ruby version of the BCrypt algorithm, an open-source option for generating powerful encryption on user passwords.

### [White String Similarity Algorithm](http://www.catalysoft.com/articles/StrikeAMatch.html)

An algorithim originally invented by Simon White, for comparing the values of two strings to determine their similarity. For Rubyists who don't wish to write their own implementation, as was done in Evening Edition, [see this Ruby gem](https://github.com/jfairbank/whitesimilarity) among others.

## Getting Started

To make your own changes to a local version of Evening Edition, begin with these steps:

1. Clone this repository (or "repo") to your local computer: <tt>git clone https://github.com/jasonpettus/evening-edition.git</tt>
2. Install the app's gems and other dependencies: <tt>bundle install</tt>
3. Initialize and seed your local database: <tt>rake db:create</tt> <tt>rake db:migrate</tt> <tt>rake db:seed</tt>
4. Start your Rails server: <tt>rails s</tt>
5. In your browser, visit <tt>http://localhost:3000</tt> for a live version of your local build

## Contributing and Workflow

Evening Edition is an open-source project and welcomes contributions from the general public, especially those who are in the same student position as the original developers of this app when it was first created. In that spirit, we'd like to share the workflow process we adhered to as students of [DevBootcamp](http://www.devbootcamp.com), in the hopes that will help those of you interested in contributing to a public project for the first time.

1. To begin with, make a local version of this repo by following the steps above.

2. Create a new branch for whatever work you decide to do, and name it something easily identifiable:

  - <tt>git checkout -b jane-smith-branch</tt>

3. When you're ready to submit your work for peer review, start by staging and committing your local branch:

  - <tt>git add .</tt>
  - <tt>git commit</tt> (Separate page will appear for your commit notes; make these as detailed as you can stand)

4. Then switch to your master copy of the repo and fetch the latest version:

  - <tt>git checkout master</tt>
  - <tt>git pull origin master</tt>

4. Then merge this latest version of the master with your local branch, resolving any merge conflicts along the way:

  - <tt>git checkout jane-smith-branch</tt>
  - <tt>git merge master</tt>

5. Now push your local branch to this Github repo:

  - <tt>git push origin jane-smith-branch</tt>

6. And finally click on "Pull Requests" in the upper-right corner of this page, then choose "New Pull Request" on the next page, comparing your local branch with the master and adding copious notes to the changes you'd like to submit. One of the administrators of this repo (or any repo, if you're duplicating these steps elsewhere) will review your changes and either
approve them, reject them, or modify bits and pieces of what you have submitted. Congratulations -- you have now contributed to the growing pool of shared public knowledge about the world!

## Development and Testing

Evening Edition was created under the precepts of Agile development, scrum project management, and test-driven coding, using a combination of RSpec, Jasmine, Capybara, Coveralls, TravisCI, Database Cleaner and Factory Girl.

## Credits

Evening Edition was originally created by Emmanuel Obi, Jason Pettus and Ben Wootten, as their final project in the "DevBootcamp" coding program in Chicago, July 2015.

[Emmanuel Obi on Github](https://github.com/withtwoemms)
[Jason Pettus on Github](https://github.com/jasonpettus)
[Ben Wootten on Github](https://github.com/bwootten)
