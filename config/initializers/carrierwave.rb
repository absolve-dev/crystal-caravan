Excon.defaults[:write_timeout] = 700
Excon.defaults[:read_timeout] = 700

CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJJGX5P5AQJ4EX5UQ',                        # required
    :aws_secret_access_key  => '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',                     # required
    :region                 => 'us-west-1',                  # optional, defaults to 'us-east-1'
    :host                   => 's3-us-west-1.amazonaws.com',             # optional, defaults to nil
    :endpoint               => "https://s3-us-west-1.amazonaws.com", # optional, defaults to nil
    #:path_style             => true,
    :persistent             => false
  }
  config.fog_directory  = 'absolve-gaming'                             # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end

