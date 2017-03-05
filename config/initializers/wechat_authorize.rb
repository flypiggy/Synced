namespace = 'Synced:weixin_authorize'
redis = Redis.new(host: '127.0.0.1', port: '6379', db: 15)

# Clear keys after restart
redis.keys("#{namespace}:*").each { |key| redis.del(key) }

weixin_authorize_redis = Redis::Namespace.new(namespace, redis: redis)

WeixinAuthorize.configure do |config|
  config.redis = weixin_authorize_redis
end

$wechat_client = WeixinAuthorize::Client.new(ENV['WECHAT_APP_ID'], ENV['WECHAT_APP_SECRET'])

if Rails.env.development?
  # dev
  $wechat_client = WeixinAuthorize::Client.new('wx23793de73ad05e5f', '0363fa31bef050125db75a7af638dd5b')
end
