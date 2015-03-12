class GalleryController < ApplicationController
  require 'flickr_config'
  require 'flickraw'

  FlickRaw.api_key = FlickrConfig.config[:key]
  FlickRaw.shared_secret = FlickrConfig.config[:secret]

  def index
  end

  def search
    query_string = params[:q] && params[:q].strip || ''
    if (query_string == '')
      redirect_to action: 'index'
      return
    end

    @photos = get_recent_photos query_string

    if @photos == []
      redirect_to root_url, alert: 'Nothing found!'
    end
  end

  private

  def get_recent_photos query_string
    if query_string == nil ||
        (query_string && query_string.strip!) == ''
      return []
    end

    list = flickr.photos.search tags: query_string, per_page: 20

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

    res_photos
  end
end
