require 'minitest/autorun'
require 'yaml'
require_relative 'solution'

 class TracksTest < Minitest::Test
   def new_track
     Track.new 'KAYTRANADA feat. Shay Lia', 'Leave me alone', 'So Bad', 'Dance'
   end

   def test_track_with_wrong_number_of_arguments
     assert_raises(ArgumentError) { Track.new 'arg1', 'arg2', 'arg3' }
     assert_raises(ArgumentError) { Track.new 'arg1', 'arg2' }
     assert_raises(ArgumentError) { Track.new 'arg1' }
     assert_raises(ArgumentError) { Track.new }
   end

   def test_track_respond_to
     track = new_track
     track.respond_to? :artist
     track.respond_to? :name
     track.respond_to? :album
     track.respond_to? :genre

     track.respond_to? :artist=
     track.respond_to? :name=
     track.respond_to? :album=
     track.respond_to? :genre=
   end

   def test_track_to_s
     assert_equal "Artist: KAYTRANADA feat. Shay Lia\n" + \
                  "TrackName: Leave me alone\n" + \
                  "Album: So Bad\n" + \
                  'Genre: Dance', new_track.to_s
   end

 end

class PlaylistTest < Minitest::Test
    def setup
      @config = YAML.load_file('songs.yml')
    end

   #  def teardown
   #    @config = nil
   #  end

    def new_playlist
      Playlist.from_yaml('songs.yml')
    end

    def new_track
      Track.new('KAYTRANADA feat. Shay Lia', 'Leave me alone', \
                'So Bad', 'Dance')
    end

    def test_playlist_initialize
      assert_raises(TypeError) { Playlist.new "alabala"}
    end

    def test_load_from_yml
      playlist = Playlist.from_yaml('songs.yml')
      playlist.each do |track|
       assert_equal true, track.instance_of?(Track)
      end
    end
end