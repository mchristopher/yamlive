Zencoder.api_key = '746459150822b53c7a09fe440435bd1d'

Dreamlive::Application.config.live_config = {
  :rtmp_publish => 'rtmp://codescool.com/live',
  :rtmp_out     => 'rtmp://codescool.com/live',
  :rtmp_append  => '',
  :hls_publish  => 'ftp://testuser:testpwd@codescool.com/outputs',
  :hls_out      => 'http://codescool.com/outputs',
  :file_out     => 'ftp://testuser:testpwd@codescool.com/outputs',
  :notify_url   => 'http://dreamlive.tv/streams'
}

