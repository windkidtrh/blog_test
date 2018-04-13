source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails',                   '5.1.5'
gem 'puma',                    '3.11.3'
gem 'sass-rails',              '5.0.7'
gem 'uglifier',                '4.1.8'
gem 'coffee-rails',            '4.2.2'
gem 'turbolinks',              '5.1.0'
gem 'jquery-rails',            '4.3.1'
gem 'jbuilder',                '2.7.0'
gem 'wdm',                     '0.1.1'
gem 'win32console',            '1.3.2'
gem 'bootstrap-sass',          '3.2.0.2'
gem 'bcrypt',                  '3.1.11'
# gem 'bcrypt-ruby',             '3.1.5',:require => 'bcrypt'
gem 'carrierwave',             '1.2.2'
gem 'mini_magick',             '4.8.0'
gem 'fog-aws',                 '2.0.1'
gem 'nokogiri',                '1.8.2'
gem 'will_paginate',           '3.1.6'
gem 'faker',                   '1.8.7'
gem 'rack-cors',               '1.0.2'
gem 'annotate',                '2.7.2'
gem 'active_model_serializers','0.10.7'  
gem 'rake',                    '12.3.1'
gem 'activerecord',            '5.1.5'
# gem 'rails-ujs',               '0.1.0'
# gem 'bootstrap-will_paginate', '1.0.0' 
# gem 'execjs',                  '2.7.0'

group :development, :test do
  gem 'byebug',  '10.0.1', platforms: :mri
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3', '1.3.13'
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
  # gem 'annotate', git: 'https://github.com/ctran/annotate_models.git'

end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest-reporters',       '1.2.0'
  gem 'guard',                    '2.14.2'
  gem 'guard-minitest',           '2.4.6'
end

group :production do
  gem 'pg','1.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
