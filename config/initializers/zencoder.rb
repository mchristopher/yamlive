Zencoder.api_key = 'FILL_IN_API_KEY'

Dreamlive::Application.config.live_config = {
  :rtmp_publish => 'rtmp://my.rtmp.server',
  :rtmp_out     => 'rtmp://my.rtmp.server',
  :rtmp_append  => '',
  :hls_publish  => 'http://my.hls.server',
  :hls_out      => 'http://my.hls.server',
  :file_publish => 's3://my-bucket',
  :file_out     => 'http://my-bucket.s3.amazonaws.com',
  :notify_url   => 'http://my.host.com/streams'
}

