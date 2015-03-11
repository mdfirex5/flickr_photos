class GalleryController < ApplicationController
  def index
  end

  def search
  end

  def show
  end

  private

  def get_recent_photos query_string
    if query_string == nil ||
        (query_string && query_string.strip!) == ''
      return []
    end

    require 'flickr_config'
    require 'flickraw'

    FlickRaw.api_key = FlickrConfig.config[:key]
    FlickRaw.shared_secret = FlickrConfig.config[:secret]

    list = flickr.photos.search text: query_string, per_page: 20

    res_photos = []

    threads = []
    list.each do |e|
      threads << Thread.new do
        title = e.title
        id = e.id
        secret = e.secret
        info = flickr.photos.getInfo photo_id: id, secret: secret

        flickr.photos.getInfo photo_id: id, secret: secret

        res_photos << {
          title: title,
          square: FlickRaw.url_s(info),
          big: FlickRaw.url_b(info)
        }
      end
    end

    threads.map(&:join)

    photos
  end
end
