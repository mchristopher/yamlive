Zencoder.api_key = 'your_key_here'

Dreamlive::Application.config.live_config = {
  :rtmp_publish => 'rtmp://example.com/live',
  :rtmp_out     => 'rtmp://example.com/live',
  :rtmp_append  => '',
  :hls_publish  => 'ftp://example.com/home/testuser/outputs',
  :hls_out      => 'http://example.com/outputs',
  :file_out     => 'ftp://example.com/home/testuser/outputs',
  :notify_url   => 'http://dreamlive.tv/streams'
}

