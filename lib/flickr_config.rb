module FlickrConfig
  def config
    @@config ||= nil
  end

  def config= (hash)
    @@config = hash
  end
end