Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_videos'
  s.version     = '3.1.1.3'
  s.summary     = 'Adds youtube videos to Spree commerce products'
  s.description = 'Add multiple youtube videos, and a thumbnail selector' +
                  'for those products to a Spree commerce product'
  s.required_ruby_version = '>= 1.9.1'

  s.author            = 'Michael Bianco'
  s.email             = 'info@cliffsidedev.com'
  s.homepage          = 'http://mabblog.com/'

  s.require_path = 'lib'
  s.requirements << 'none'


  spree_version = '>= 3.1.0', '< 5.0'
  s.add_dependency 'spree_core', spree_version
  s.add_dependency 'spree_backend', spree_version
  s.add_dependency 'spree_extension'

  #s.add_dependency 'youtube_it', '~> 2.4.1'
  s.add_dependency 'yt', '~> 0.22.0'
  s.add_dependency 'haml', '5.1.2'

  # test suite
  s.add_development_dependency 'capybara', '~> 2.10'
  s.add_development_dependency 'factory_girl_rails', '~> 4.7.0'
  s.add_development_dependency 'rspec-rails',  '~> 3.5.2'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'shoulda-matchers'
end
