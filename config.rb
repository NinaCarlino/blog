require 'pry'

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :markdown_engine, :redcarpet

set :markdown, fenced_code_blocks: true, smartypants: true

activate :syntax

# activate :relative_assets

activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.user   = ENV['BLOG_USER'] || deploy.user
  deploy.host   = 'datamelon.io'
  deploy.path   = '~/www/'
  deploy.clean  = true # remove orphaned files on remote host, default: false
end

activate :blog do |blog|

  # This will add a prefix to all links, template references and source paths
  blog.prefix = "blog"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  # blog.layout = "layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"
  blog.permalink = ":year/:title.html"
  blog.sources = ":year/:title.html"
  # blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  blog.page_link = "p{num}"
  blog.per_page = 8
  blog.layout = "blog_layout"
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, '/Content/images/'
end

# page 'index.html.haml', layout: false
page '*.html.haml', layout: false
