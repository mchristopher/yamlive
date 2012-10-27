Zencoder.api_key = '79784bcdfd41a2e6f7af0defa88ffdbe'

Dreamlive::Application.config.live_config = {
  :rtmp_publish => 'rtmp://example.com/live',
  :rtmp_out     => 'rtmp://example.com/live',
  :rtmp_append  => '',
  :hls_publish  => 'ftp://example.com/home/testuser/outputs',
  :hls_out      => 'http://example.com/outputs',
  :file_out     => 'ftp://example.com/home/testuser/outputs',
  :notify_url   => 'http://yamlive.mchristopher.com/streams'
}

