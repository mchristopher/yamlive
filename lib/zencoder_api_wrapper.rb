module ZencoderAPIWrapper

  def self.create_new_stream(stream)

    notify_url = Dreamlive::Application.config.live_config[:notify_url]

    response = Zencoder::Job.create({
        :live_stream => true,
        :outputs => [
          {
            :url => self.rtmp_publish_uri(stream),
            :notifications => [
              {
                :format => "json",
                :url => "#{notify_url}/#{stream.id}/notify"
              }
            ]
          },
          {
            :base_url => self.hls_publish_uri(stream),
            :filename => self.hls_filename(stream)
          }
        ]
    })

    if response.success?
      response.body
    end
  end

  def self.stream_uris(stream)
    {
      :hls_out => self.hls_view_uri(stream),
      :rtmp_out => self.rtmp_view_uri(stream)
    }
  end

  def self.stream_name(stream)
    "#{stream.user.username}_#{stream.name}_#{stream.id}"
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
    hls_name = "#{stream_name(stream)}"
    "#{hls_base}/#{self.stream_name(stream)}.m3u8"
  end

end
