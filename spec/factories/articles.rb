FactoryGirl.define do
  factory :article do
    title 'Letting Our Emojis Get in the Way'
    summary 'Enthusiasts think there’s always room for new icons, but the process for adding fresh emojis is surprisingly complex.'
    url 'http://rss.nytimes.com/c/34625/f/640387/s/4837f4b2/sc/14/l/0L0Snytimes0N0C20A150C0A70C180Cnytnow0Cletting0Eour0Eemojis0Eget0Ein0Ethe0Eway0Bhtml0Dpartner0Frss0Gemc0Frss/story01.htm'

    factory :article_pluto do
      title 'Pluto Terrain Yields Big Surprises in New Horizons Images'
      summary 'Images from the NASA mission show a mixed bag of terrains, including ice mountains and smooth plains crisscrossed by enigmatic troughs.'
      url 'http://rss.nytimes.com/c/34625/f/640377/s/4838d0c2/sc/32/l/0L0Snytimes0N0C20A150C0A70C180Cscience0Cspace0Cpluto0Eterrain0Eyields0Ebig0Esurprises0Ein0Enew0Ehorizons0Eimages0Bhtml0Dpartner0Frss0Gemc0Frss/story01.htm'
    end

    factory :article_british_open do
      title 'British Open Friday Update: Dustin Johnson Stays on Top'
      summary 'The second round included a three-hour rain delay, but Dustin Johnson remained at the top of the leaderboard. He was 10 under par through 13 holes before play was suspended because of darkness.'
      url 'http://rss.nytimes.com/c/34625/f/640382/s/4835769d/sc/13/l/0L0Snytimes0N0C20A150C0A70C180Csports0Cgolf0Cbritish0Eopen0Efriday0Espieth0Ejohnson0Bhtml0Dpartner0Frss0Gemc0Frss/story01.htm'
    end
  end
end
