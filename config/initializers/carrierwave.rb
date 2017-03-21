CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage              = :qiniu
    config.qiniu_access_key     = ENV['QINIU_ACCESS_KEY']
    config.qiniu_secret_key     = ENV['QINIU_SECRET_KEY']
    config.qiniu_bucket         = 'image'
    config.qiniu_bucket_domain  = 'image.jiqizhixin.com'
    config.qiniu_bucket_private = true
    config.qiniu_block_size     = 4 * 1024 * 1024
    config.qiniu_protocol       = 'http'
  else
    config.storage              = :file
  end
end
