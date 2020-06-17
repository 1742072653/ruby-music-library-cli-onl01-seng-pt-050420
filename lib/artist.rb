require 'pry'
class Artist
  extend Concerns::Findable 
  attr_accessor :name, :songs
  
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end
  
  def add_song(song)
    if song.artist == nil 
      song.artist = self 
    end
    if @songs.include?(song) == false
      @songs << song
    end
  end
  
  def genres 
    array = []
    @songs.each do |song|
      if array.include?(song.genre) == false 
        array << song.genre 
      end
    end
    array
  end

  def self.all
    @@all
  end
  
  def save
    @@all << self
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end
   
end
