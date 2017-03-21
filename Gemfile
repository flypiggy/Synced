source 'https://gems.ruby-china.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use warden for user authenticate
gem 'warden'
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Use Redis adapter to run Action Cable in production
gem 'redis-rails', '~> 5'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Pagination
gem 'kaminari'
# Authorization
gem 'pundit'
# Pinyin
gem 'ruby-pinyin'

# UploadImage
gem 'carrierwave-qiniu', '~> 1.1.0'
gem 'remotipart', '~> 1.2'

# AddForSearch
gem 'ransack'

# SortModel
gem 'ranked-model'

# Use dotenv for envs
gem 'dotenv-rails', require: 'dotenv/rails-now'

# Front-End
gem 'autoprefixer-rails'
gem 'browser', '~> 2.3'
gem 'materialize-sass'
gem 'material_icons'
gem 'meta-tags', '~> 2.4'
gem 'normalize-rails', '~> 4.1', '>= 4.1.1'
gem 'perfect-scrollbar-rails'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'slim', '~> 3.0', '>= 3.0.7'
gem 'webpacker', '~> 1.0'

# Wechat sdk
gem 'weixin_authorize'

group :development, :test do
  # Call 'binding.pry' anywhere in the code to stop execution and get a debugger console
  gem 'pry-byebug'

  # For deployment
  gem 'capistrano',         require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-rbenv',   require: false
  gem 'capistrano-yarn',    require: false
  gem 'capistrano3-puma',   require: false
  gem 'slackistrano'

  # Guard
  gem 'guard-rspec', require: false
  gem 'terminal-notifier-guard' # This need terminal-notifier, brew install it
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'web-console', '>= 3.3.0'

  # LiveReload
  gem 'guard-livereload', '~> 2.5', require: false

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Use pry for debug and replace the default rails console
  gem 'awesome_print'
  gem 'pry-rails'

  # For rails pannel
  gem 'meta_request'

  # DB structure
  gem 'annotate'

  # Code analyzer
  gem 'overcommit', require: false
  gem 'rubocop', require: false
end

group :test do
  gem 'codeclimate-test-reporter', '~> 1.0.0'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.5'
  gem 'simplecov'
end

group :production do
end
