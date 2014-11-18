 require 'yaml'

 class Track
   attr_accessor :artist, :name, :album, :genre

   def initialize(*arguments)
     if arguments.size == 4
       @artist = arguments[0]
       @name   = arguments[1]
       @album  = arguments[2]
       @genre  = arguments[3]
     elsif arguments.size == 1
       fail ArgumentError, 'Hash with four arguments requared' \
        unless arguments[0].instance_of? Hash
           @artist = arguments[0][:artist]
           @name   = arguments[0][:name]
           @album  = arguments[0][:album]
           @genre  = arguments[0][:genre]
     else
       fail ArgumentError, 'Enter artist, name, album and genre.'
     end
   end

   def to_s
     "Artist: #{@artist}\nTrackName: #{@name}\n" + \
     "Album: #{@album}\nGenre: #{@genre}"
   end

 end

 class Playlist

   def initialize(*tracks)
     @tracks = []
     tracks.each do |track|
      raise TypeError unless track.instance_of? Track
      @tracks << track
     end
   end

   def self.from_yaml(path)
     tracks = []
     new_tracks = YAML.load_file(path)
     new_tracks.each { |track| track << Track.new(track.with_indifferent_access) }
     Playlist.new(*tracks)
   end



   def each
     if block_given?
       @tracks.each {|track| yield(track)}
     else
       @tracks.enum_for (:each)
     end
   end

#   def find(&block)
#     Playlist.new(@tracks.select { |track| block.call(track) })
#   end

#   def find_by(*filters)
#     Playlist.new @tracks.select do |track|
#       filters.all? {|filter| filter call track}
#   end

#   def find_by_name(name)
#     Playlist.new(@tracks.select { |track| track.name.include? name })
#   end

#   def find_by_artist(artist)
#     Playlist.new(@tracks.select { |track| track.artist.include? artist })
#   end

#   def find_by_album(album)
#     Playlist.new(@tracks.select { |track| track.album.include? album })
#   end

#   def find_by_genre(genre)
#     Playlist.new(@tracks.select { |track| track.genre.include? genre })
#   end

#   def shuffle
#     Playlist.new(@tracks.shuffle)
#   end

#   def random
#     @tracks[Random.rand(@tracks.length)]
#   end

#   def to_s
#     result = ''
#     @tracks.each { |track| result += track.to_s + "\n\n" }
#     result
#   end

#   def &(other)
#     raise ArgumentError, 'Enter valid argument type' \
#   unless other.instance_of? Playlist
#     Playlist.new @tracks & other.tracks
#   end

#   def |(other)
#     raise ArgumentError, 'Enter valid argument type' \
#     unless other.instance_of? Playlist
#     Playlist.new @tracks | other.tracks
#   end

#   def -(other)
#     raise ArgumentError, 'Enter valid argument type' \
#     unless other.instance_of? Playlist
#     Playlist.new @tracks - other.tracks
#   end

#   def ==(other)
#     raise ArgumentError, 'Enter valid argument type' \
#   unless other.instance_of? Playlist
#     @tracks == other.tracks
#   end
#  end
 end

#   class AwesomeArtistsFilter
#     AWESOME_ARTISTS = %w(Iron\ Maiden Metallica Linkin\ Park)

#   def call(track)
#     AWESOME_ARTISTS.include? track.artist
#   end

#   end

#   class AwesomeSongsFilter
#     AWESOME_SONGS = %w(One Nothing\ else\ matters)

#   def call(track)
#     AWESOME_SONGS.include? track.name
#   end

# end

class HashWithIndifferentAccess < Hash
  attr_reader :hash

  def initialize(argument)
    fail ArgumentError, 'Enter valid argument type' unless argument.instance_of?(Hash)
    @hash = {}
    argument.each do |key, value|
      new_key = key.instance_of?(Symbol) ? key.to_s : key
      @hash[new_key] = value
    end
  end

  def [](key)
    @hash[key.instance_of?(Symbol) ? key.to_s : key]
  end

  def []=(key, value)
    @hash[key.instance_of?(Symbol) ? key.to_s : key] = value
  end

  def ==(other)
    fail ArgumentError, 'other must be of type HashWithIndifferentAccess' \
      unless other.instance_of? HashWithIndifferentAccess
    @hash == other.hash
  end

  def fetch(key)
    @hash[key.instance_of?(Symbol) ? key.to_s : key]
  end

end

class Hash
  def with_indifferent_access
    HashWithIndifferentAccess.new(self)
  end
end