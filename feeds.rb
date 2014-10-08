# coding: utf-8
require 'yaml'
require 'pp'
require 'feedjira'
require 'active_support/all'

# read configration
load File::expand_path('', File::dirname(__FILE__)) + '/config.rb'

feeds_file = File::expand_path('', File::dirname(__FILE__)) + '/feeds.yml'

urls = YAML.load(File.read(feeds_file))
pp urls


urls.each do |item|

  feed = Feedjira::Feed.fetch_and_parse(item['url'])

  feed.entries.each do |entry|

    #puts "-----"
    #puts entry.title
    #puts entry.url
    #puts entry.published

    now = Time.now
    updated = entry.published.getlocal
    #p "#{updated} >= #{now.yesterday}"

    if updated >= now.yesterday

      # via ikachan
      system("curl -F channel=\##{$IRC_CHANNEL} -F message=\"MobileFirst [#{item['title']}] #{entry.title} - #{entry.published} \" #{$IRC_URL}")
      system("curl -F channel=\##{$IRC_CHANNEL} -F message=\"MobileFirst #{entry.url}  \" #{$IRC_URL}")

    end

  end

end
