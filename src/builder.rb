require "discorb"

module Builder

    class Embed_Factory
        
        def initialize
            @embed = Discorb::Embed.new 
            
        end
        
        def set_title( title ) 
            @embed.title = title
            return self
        end

        def set_description( description ) 
            @embed.description = description
            return self 
        end 
        
        def set_url( url ) 
            @embed.url = url 
            return self
        end

        def set_timestamp( timestamp ) 
            @embed.timestamp = timestamp 
            return self
        end

        def set_color( r, g, b ) 
            @embed.color = Discorb::Color.from_rgb(r, g, b)
            return self
        end

        def set_footer( footer ) 
            @embed.footer = footer 
            return self
        end

        def set_thumbnail( thumbnail ) 
            @embed.thumbnail = thumbnail 
            return self
        end


        def add_field( name, value ) 
            @embed.fields << Discorb::Embed::Field.new(name, value) 
            return self
        end

        def build
            return @embed
        end
    end

    class Selection_Factory

        def initialize( name )
            @name = name 
            @choices = []
        end

        def add_choice( name, desc, id )
            emotes = %w(musical_note notes sound loud_sound)
            @choices << Discorb::SelectMenu::Option.new( name, id, description: desc, emoji: Discorb::UnicodeEmoji.new(emotes.sample) )
            return self
        end

        def build 
            return Discorb::SelectMenu.new(@name, @choices)
        end
    end
end