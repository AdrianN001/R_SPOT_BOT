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
            @playlist = spotify_playlist.shuffle[0, 60]
        end

        def analize 
            
            #     Get an array of the : 
            #                             -danceability
            #                             -energy
            #                             -tempo
            #                             -length (duration_ms)
                                        
                
           
            track_size = @playlist.length

            @danceability = [] 
            @energy = []
            @tempo = []
            @length = []
            

            if track_size >= 20 then 

                threads = []   # One thread should do only ~20 song

                (track_size / 20).times do | i | 
                    thread = Thread.new {
                        @playlist[i*20, 20].each do |item| 
                            if item.audio_features then
                                @danceability.append(item.audio_features.danceability)
                                @energy.append(item.audio_features.energy)
                                @tempo.append(item.audio_features.tempo)
                                @length.append(item.audio_features.duration_ms / 1000)
                                puts item
                            end
                        end
                            
                    }
                    threads << thread
                end

                threads.each do |thread| 
                    thread.join
                end
            else 
                @playlist.each do | song | 
                    @danceability.append(song.audio_features.danceability)
                    @energy.append(song.audio_features.energy)
                    @tempo.append(song.audio_features.tempo)
                    @length.append(song.audio_features.duration_ms / 1000)
                end
            end
            

        end



        def get_result 
            danceability_avg = ( (@danceability.sum / @danceability.length) * 100).to_i  # percentage
            energy_avg = ( (@energy.sum / @energy.length) * 100).to_i                    # percentage
            tempo_avg = (@tempo.sum / @tempo.length).to_i
            length_avg = @length.sum / @length.length

            puts "#{danceability_avg} #{energy_avg} #{tempo_avg} #{length_avg}"
            return {"Táncolhatóság" => "#{danceability_avg} %", "Energia" => "#{energy_avg} %", "Tempója" => tempo_avg, "Átlag hossz" => "#{length_avg} másodperc"}
        end

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
            @chosen_playlist = playlist_id
            return @user_object.playlists[playlist_id].tracks
        end

        def get_playlist_data
            desc = get_playlist()[@chosen_playlist].description
            name = get_playlist()[@chosen_playlist].name
            img = get_playlist()[@chosen_playlist].images[0]["url"]
            return [desc,name, img]
        end

    end
end 