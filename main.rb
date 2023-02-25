require "discorb"
require_relative "src/builder.rb"
require_relative "src/spoti.rb"
require "dotenv"
Dotenv.load


intents = Discorb::Intents.new
intents.message_content = true
$client = Discorb::Client.new(intents: intents)



END{
  $client.run(ENV["DISCORD_BOT_TOKEN"])
}

$client.once :standby do
  puts "Logged in as #{$client.user}"
end

$client.slash("ping", "Ping!") do |interaction|
  interaction.post("Pong!", ephemeral: true)
end

choices = [ 
  [1, "kek"], 
  [2, "piros"]
].freeze


$client.slash("color", "Valaszd ki a kedvenc szined") do | interaction | 
  options = choices.map.with_index do | item, i |
    Discorb::SelectMenu::Option.new(
      "Page #{i + 1}",
      "choice:#{i}",
      description: item[0]
    )
  end

  interaction.post(
    "Select a section", 
    components: [Discorb::SelectMenu.new("choices", options)]
  )
end


$client.on :message do |message|
  next if message.author.bot?
  next unless message.content.start_with?("analize ")
  user_name = message.content.delete_prefix("analize ")

  unless user_exists?( user_name ) then
    message.reply("Nincsen ilyen felhasznalónév\n Ha segitség kell: analize --help")
    next
  end

  user = Spotify::User.new(user_name)
  playlists = user.get_playlist



  embed_built = Builder::Embed_Factory.new
  select_built = Builder::Selection_Factory.new "selection_custom_id"

  embed_built.set_title("Szia #{user_name}")
             .set_description("Több playlistet is találtunk a profilodon")
             .set_thumbnail("https://1000logos.net/wp-content/uploads/2017/06/Ubuntu-Logo.png")
             .add_field("Válaszd ki azt amelyiket szeretnéd hogy értékeljem.", "...")
             .set_color(30, 215, 96)       

  playlists.each_with_index do | playlist , index | 
    select_built.add_choice(playlist.name, "Bottom text", "#{index} #{user_name}")
  end

  # select_built.add_choice( "Nev 1", "Leiras 1", "1 #{user_name}")
  #             .add_choice( "Nev 2", "Leiras 2", "2 #{user_name}")
  #             .add_choice( "Nev 3", "Leiras 3", "3 #{user_name}")
  #             .add_choice( "Nev 4", "Leiras 4", "4 #{user_name}")

  message.reply(embed: embed_built.build , components: [select_built.build ] )
end

$client.on :select_menu_select do |response|
  next unless response.custom_id == "selection_custom_id"

  playlist = response.value[0]
  user_name = response.value[playlist.length + 1, response.value.length]

  user = Spotify::User.new(user_name)

  puts "playlist: #{playlist} username: #{user_name}"

  response.post(
    response.value,
    ephemeral:true
  )
end