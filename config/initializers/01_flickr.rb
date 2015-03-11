require 'flickr_config'

FlickrConfig.config[:key] = ENV["FLICKR_CONFIG_KEY"]
FlickrConfig.config[:secret] = ENV["FLICKR_CONFIG_SECRET"]