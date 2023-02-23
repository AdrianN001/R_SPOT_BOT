require "rspotify"
require "dotenv"
Dotenv.load "../.env"

RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])


me = RSpotify::User.find('gogosadrian')
puts me.playlists #=> (Playlist array)

playlists = me.playlists

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


class Session 

    def initalize( user_name )
        @user_name = user_name
        begin                                                # try
            @user_profile = RSpotify::User.find(user_name)
        rescue                                               # catch
            puts "[*] Error: no user as #{user_name}"
        end
    
    end


    def get_playlist( playlist_id ) 
    end

    def get_favourites() 
    end
end