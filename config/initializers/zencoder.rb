Zencoder.api_key = '79784bcdfd41a2e6f7af0defa88ffdbe'

Dreamlive::Application.config.live_config = {
  :rtmp_publish => 'rtmp://brightcove-289:hfsbef@fmspush.iad.llnw.net/brightcove/289',
  :rtmp_out     => 'rtmp://brightcove.fc.llnwd.net/brightcove/289',
  :rtmp_append  => '',
  :hls_publish  => 'http://post.bcoveliveios-i.akamaihd.net/204874/1769255312001/yamlive',
  :hls_out      => 'http://bcoveliveios-i.akamaihd.net/hls/live/204874/1769255312001/yamlive',
  :file_publish => 's3://zencoder-video-outputs/yamlive/prod',
  :file_out     => 'http://zencoder-video-outputs.s3.amazonaws.com/yamlive/prod',
  :notify_url   => 'http://yamlive.mchristopher.com/streams'
}

