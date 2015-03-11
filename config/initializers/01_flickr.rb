require 'flickr_config'

FlickrConfig.config[:key] = ENV["FLICKR_API_KEY"]
FlickrConfig.config[:secret] = ENV["FLICKR_SHARED_SECRET"]