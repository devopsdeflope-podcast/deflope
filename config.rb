require 'lib/feed_helpers'
require 'mp3info'

activate :blog do |blog|
  blog.prefix = 'posts'
  blog.permalink = ':year/:title.html'
  blog.sources = '{year}/{year}-{month}-{day}-{title}.html'
  blog.paginate = true
  blog.per_page = 3
  blog.summary_length = 4_000
end

activate :s3_sync do |s3_sync|
  s3_sync.bucket = 'devopsdeflope.ru'
  s3_sync.region = 'eu-west-1'
  s3_sync.after_build = true
  s3_sync.delete = true
end

caching_policy 'text/html', max_age: 0, must_revalidate: true
caching_policy 'image/png', max_age:(60 * 60 * 24 * 365)
caching_policy 'text/css', max_age:(60 * 60 * 24 * 365)
caching_policy 'application/javascript', max_age:(60 * 60 * 24 * 365)

Fog::Logger[:warning] = nil

activate :cache_buster

# Per-page layout changes:
#
# With no layout
page "/feeds/episodes.rss", :layout => false
page "/feeds/itunes.xml", :layout => false
page "/archive", :proxy => "/archive.html"

###
# Helpers
###

helpers FeedHelpers
# Methods defined in the helpers block are available in templates
helpers do
  def site_url(protocol = 'http')
    if development?
      "#{protocol}://localhost:4567"
    else
      "#{protocol}://devopsdeflope.ru"
    end
  end

  def mp3file_exist?(article_title)
    File.exist?("./source/mp3/#{get_mp3_filename(article_title)}")
  end

  def get_mp3_filename(article_title)
    "deflope" + article_title.match(/^\d+/).to_s + ".mp3"
  end

  def get_audio_duration(path)
    Mp3Info.open(path, :parse_tags => false) { |file| Time.at(file.length).gmtime.strftime('%R:%S') }
  end

  def get_audio_size(path)
    File.size(path)
  end
end
# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true,
               autolink: true,
               smartypants: true,
               with_toc_data: true

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
