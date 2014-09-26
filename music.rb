require 'csv'

class GetData
  def initialize(filename)
    @filename = filename
  end

  def make_catalog
    @catalog = Hash.new
    CSV.foreach(@filename, headers: true) do |row|
      @artist = row["Artist"].to_s
      @name = row["Name"]
      add_song
    end
    @catalog
  end

  def add_song
    if @catalog.has_key?(@artist)
      @catalog[@artist] << @name
    else
      @catalog[@artist]= Array.new
      @catalog[@artist]  << @name
    end
  end
end

class CatalogOfSongs
  def initialize(songs)
    @songs = songs
  end

  def list_songs
    get_user_input
    print_title
    puts @songs[@artist_input]
  end

  private

  def get_user_input
    puts "Here are the artists in your catalog: #{@songs.keys}"
    print "Which artist's songs would you like to see? >"
    @artist_input = gets.chomp
  end

  def print_title
    title = "The Infinitely Inspiring Works of #{@artist_input}:"
    stars = title.length
    puts "*" * stars 
    puts title
    puts "*" * stars
  end
end

data = GetData.new("music.csv")

songs = CatalogOfSongs.new(data.make_catalog)
songs.list_songs
