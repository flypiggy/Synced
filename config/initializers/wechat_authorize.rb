redis_store = Redis::Store.new(host: '127.0.0.1', port: '6379', db: 15, namespace: 'weixin_authorize')

# Clear keys after restart
redis_store.flushdb

WeixinAuthorize.configure do |config|
  config.redis = redis_store
end

$wechat_client = WeixinAuthorize::Client.new(ENV['WECHAT_APP_ID'], ENV['WECHAT_APP_SECRET'])
