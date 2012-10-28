module ZencoderAPIWrapper

  def self.create_new_stream(stream)

    notify_url = Dreamlive::Application.config.live_config[:notify_url]

    response = Zencoder::Job.create({
        :live_stream => true,
        :notifications => ["#{Dreamlive::Application.config.live_config[:notify_url]}/#{stream.id}/notify"],
        :outputs => [
          {
            :url => self.rtmp_publish_uri(stream)
          },
          {
            :url => self.http_publish_uri(stream),
            :public => true
          },
          {
            :type         => "segmented",
            :instant_play => true,
            :base_url     => self.hls_publish_uri(stream),
            :filename     => self.hls_filename(stream),
            :notifications => [
              {
                :url => "#{Dreamlive::Application.config.live_config[:notify_url]}/#{stream.id}/notify",
                :event => "first_segment_uploaded"
              }
            ]
          }
        ]
    })

    # TODO: Parse the response
    if response.success?
      response.body
    else
      puts response.body
      puts response.code
    end
  end

  def self.http_publish_uri(stream)
    http_base = Dreamlive::Application.config.live_config[:file_publish]
    "#{http_base}/#{stream_name(stream)}.mp4"
  end

  def self.http_view_uri(stream)
    http_base = Dreamlive::Application.config.live_config[:file_out]
    "#{http_base}/#{stream_name(stream)}.mp4"
  end

  def self.stream_uris(stream)
    {
      :hls_out => self.hls_view_uri(stream),
      :http_out => self.http_view_uri(stream),
      :rtmp_out => self.rtmp_view_uri(stream)
    }
  end

  def self.stream_name(stream)
    "#{stream.user.id}_#{stream.id}_#{stream.url_slug}"
  end

  def self.rtmp_publish_uri(stream)
    rtmp_base = Dreamlive::Application.config.live_config[:rtmp_publish]
    rtmp_name = "#{stream_name(stream)}#{Dreamlive::Application.config.live_config[:rtmp_append]}"
    "#{rtmp_base}/#{rtmp_name}"
  end

  def self.rtmp_view_uri(stream)
    rtmp_base = Dreamlive::Application.config.live_config[:rtmp_out]
    rtmp_append = Dreamlive::Application.config.live_config[:rtmp_append]
    "#{rtmp_base}/#{self.stream_name(stream)}#{rtmp_append}"
  end

  def self.hls_publish_uri(stream)
    hls_base = Dreamlive::Application.config.live_config[:hls_publish]
    hls_name = "#{stream_name(stream)}"
    "#{hls_base}/#{hls_name}"
  end

  def self.hls_filename(stream)
    "#{self.stream_name(stream)}.m3u8"
  end

  def self.hls_view_uri(stream)
    hls_base = Dreamlive::Application.config.live_config[:hls_out]
    hls_name = stream_name(stream)
    "#{hls_base}/#{hls_name}/#{hls_name}.m3u8"
  end

end
