# name: SoundCloud Onebox
# about: Overrides the SoundCloud onebox
# version: 0.1
# authors: scossar

class Onebox::Engine::SoundCloudOnebox
  include Onebox::Engine
  include Onebox::Engine::StandardEmbed

  matches_regexp(/^https?:\/\/.*soundcloud\.com/)
  always_https

  def to_html
    oembed_data = get_oembed_data[:html]
    unless set?
      oembed_data.gsub!('height="400"', 'height="166"')
    end
    oembed_data.gsub!('visual=true', 'visual=false')
  end

  def placeholder_html
    "<img src='#{get_oembed_data[:thumbnail_url]}'>"
  end

  private

  def set?
    # url =~ /\/sets\//
  end

  def get_oembed_data
    Onebox::Helpers.symbolize_keys(::MultiJson.load(Onebox::Helpers.fetch_response("https://soundcloud.com/oembed.json?url=#{url}").body))
  end

end
