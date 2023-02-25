require "rspotify"
require "dotenv"
Dotenv.load ".env"

RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])


# me = RSpotify::User.find('gogosadrian')
# puts me.playlists #=> (Playlist array)

# playlists = me.playlists

# playlists.each do |playlist|
#     puts playlist.name
# end

# playlists[0].tracks.each do | track | 
#     puts track.name
#     puts track.audio_features.danceability
#     puts track.audio_features.energy
#     puts "Length: #{track.audio_features.duration_ms }"
#     puts "______-----------------------------------_______________--___-__-__--__-"
# end

def user_exists?( user_name ) 
    begin                                          # try 
        _temp = RSpotify::User.find(user_name)
    rescue => exception                            # catch 
        return false
    end
    return true
end

module Spotify

    class Analizer

        def initialize( spotify_playlist ) 
            @playlist = spotify_playlist
        end

        def analize 
            =begin
                Get an array of the : 
                                        -danceability
                                        -energy
                                        -tempo
                                        -length (duration_ms)
                                        
                
            =end
            track_size = @playlist.length

            danceability = [] 
            energy = []
            tempo = []
            length = []
            
            threads = []   # One thread should do only ~20 song





    end


    

    class User
      

        def initialize( user_name ) 
            @user_name = user_name
            
            begin                                          # try 
                @user_object = RSpotify::User.find(user_name)
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
end 