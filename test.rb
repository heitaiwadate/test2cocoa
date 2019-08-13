::RBNACL_LIBSODIUM_GEM_LIB_PATH = './libsodium.dll'
require 'discordrb'
require 'open3'
require 'twitter'


bot = Discordrb::Commands::CommandBot.new token: 'Mzc3MzU4Mzk4ODUwNTk2ODY0.DOLyFQ.cHZ-V_If-wP0Vki51z5ZR93ejO4', prefix: '!'
play = 1
bot.command(:summon) do |event|

channel = event.user.voice_channel

  next "ボイスチャンネルに入室してください！" unless channel

  bot.voice_connect(channel)
  "#{channel.name}に入室しました
!helpで現在再生可能な曲とコマンドが表示されます。"
end

#再生を止める





bot.command (:stop) do |event|
  play = 1
  bot.game = ("何もしてないよ！")
  event.voice.stop_playing
  def stop()
      event.voice.stop_playing
  end
end


bot.command(:play?) do |event|
  stats = event.voice.playing?
end

bot.command (:exit) do |event|
  bot.game = ("何もしてないよ！")
  event.voice.destroy
end

bot.command(:pause) do |event|
  event.voice.pause
end

bot.command(:cont) do |event|
  event.voice.continue
end


#youtube

def youtube(url)
  Open3.capture3('youtube-dl -x --audio-format mp3 --id --no-cache-dir ' + "#{url}")
  Open3.capture3('ren *.mp3 a.mp3')
end


bot.command (:play) do |event,*url|
  play = 0
  bot.game = ("Youtube")
  Open3.capture3('del /s *mp3')
  url = url[0]

  youtube(url)

  sleep(2)

  event.send_message "ダウンロードが終わりました再生します"

  while play < 1 do
    event.voice.play_file("a.mp3")
  end
end
#ここまでyoutube



#音楽


  bot.command (:pastel)  do |event|




  play = 0

   bot.game = ("世界は恋に落ちている")

   i = 0

     while play < 1 do
       i += 1
       a = i%10

       if a ===0
         event.send_message "#{i}回目の再生です。"
       end

      event.voice.play_file('data/otaku.m4a')
     end
  end

  bot.command (:rebirth) do |event|

    play = 0

    bot.game = ("Re:birth day")

   i = 0

     while play < 1 do

       i += 1
       a = i%10

       if a ===0
         event.send_message "#{i}回目の再生です。"
       end

       event.voice.play_file('data/Rebirth.m4a')
     end
  end

#遊び

 bot.command (:tweet) do |client|

      hito = client.user.name #コマンドを使った人の名前を保存
      client.send_message"ツイートしたい内容を入力してください"

      client.user.await(:wait) do |tweet|     #ツイートする内容を取得する
      naiyou = tweet.message.content  #ツイートする内容を保存する


      client = Twitter::REST::Client.new do |config|     #ツイートするアカウントの情報を取得
        config.consumer_key        = "K4R6MNRZzLkYU73QOtoT8yqct"
        config.consumer_secret     = "8H9TT23mPuuhQ16olm1TwO05wSpkHIqIW2BtfVah6QRW3JiztL"
        config.access_token        = "3501608173-wbOHmiIPi0orTcYWSDIUvTvWk0Yw43kA1lJIxoC"
        config.access_token_secret = "rJ7Fa8yk6jhYBwwPFZpxndo6Ar4prP5kJnK01uOiTXx2i"
    end
        client.update("Discordから「#{hito}」のツイートです。『#{naiyou}』") #ツイート
  end
end

bot.run