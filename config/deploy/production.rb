Dotenv.load
set :ssh_options, keys: ['config/deploy_rsa'] if File.exist?('config/deploy_rsa')
set :slackistrano, channel: '#dev', webhook: ENV['SLACKHOOK']
server '182.92.174.188', user: 'www', roles: %w(app db web), primary: true, port: 18222
