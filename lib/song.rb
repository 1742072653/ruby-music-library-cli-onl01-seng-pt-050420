class Song 
  attr_accessor:name, :artist, :genre
  @@all=[]
  extend Concerns::Findable 
  
  def initialize(name,artist = nil,genre = nil)
    @name = name
    @artist = artist
    @genre = genre
    @artist.add_song(self)
    if @genre.songs.include?(self) == false 
      @genre.songs << self 
    end
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
    song = Song.new(name)
    song.save
    song
  end
  
  def self.new_from_filename(filename)  
    array = filename.split(" - ")
    artist = Artist.find_or_create_by_name(array[0])
    genre = Genre.find_or_create_by_name(array[2].split(".mp3").join)
    self.new(array[1],artist,genre)

  end
  
  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
  end
  
  def self.find_by_name(name)
    super
  end
end