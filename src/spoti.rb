require "rspotify"
require "dotenv"
Dotenv.load "../.env"

RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])


me = RSpotify::User.find('gogosadrian')
puts me.playlists #=> (Playlist array)

playlists = me.playlists

playlists.each do |playlist|
    puts playlist.name
end

playlists[0].tracks.each do | track | 
    puts track.name
    puts track.audio_features.danceability
    puts track.audio_features.energy
    puts "Length: #{track.audio_features.duration_ms }"
    puts "______-----------------------------------_______________--___-__-__--__-"
end

# playlists.each do | playlist |  
#     puts playlist.tracks.artists
#     puts "_-----------------_"
# end


class Analizer

    def initalize( spotify_playlist ) 
        @playlist = spotify_playlist
    end

    def 

class Spotify_User

    attr_accessor user_name

    def initalize( user_name ) 
        @user_name = user_name
        
        begin                                          # try 
            @user_object = RSpotify::User.find()
        rescue => exception                            # catch 
            puts "[*] ERROR: No spotify user as #{user_name}"
        end
    end

    def get_playlist()
        #returns the playlists of the user_object
        return @user_object.playlists
    end

    def get_track_of_playlist(playlist_id)
        # Playlist id = index of playlists  
        return @user_object.playlist[playlist_id].tracks
    end

end