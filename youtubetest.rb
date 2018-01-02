require 'open3'


class Mediadl
  def initialize(file_name="./download_urls.txt")
    @file = file_name
  end

  def dl

    File.open(@file,'r').each do |url|
      Open3.capture3('youtube-dl -x --audio-format mp3 --id --no-cache-dir ' + "#{url}")
      Open3.capture3('ren *.mp3 a.mp3')
    end
    Process.waitall
  end
end

download = Mediadl.new
download.dl
