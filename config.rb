# Configuration
config[:js_dir] = 'assets/javascripts'
config[:css_dir] = 'assets/stylesheets'
config[:layout_dir] = ''
config[:images_dir] = 'images'

config[:protocol] = 'http://'
config[:host] = 'www.blaketidwell.com'
config[:url_root] = 'http://www.blaketidwell.com'
config[:port] = 80

config[:markdown_engine] = :redcarpet
config[:markdown] = { fenced_code_blocks: true, smartypants: true }

# Time.zone = 'UTC'

###
# Page options, layouts, aliases and proxies
###
data.redirects.each do |r|
  redirect r.from, to: r.to
end

page '/feed.xml', layout: false

# Per-page layout changes:
#
# With no layout
# page '/path/to/file.html', layout: false
#
# With alternative layout
# page '/path/to/file.html', layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page '/admin/*'
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy '/this-page-has-no-template.html', '/template-file.html', locals: {
#  which_fake_page: 'Rendering a fake page with a local variable' }

# Plugins
# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = 'blog'

  blog.permalink = "articles/{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "articles/{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  blog.layout = 'article'
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = 'tag.html'
  blog.calendar_template = 'calendar.html'

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

# activate :deploy do |deploy|
#   deploy.build_before = true # default: false
#   deploy.method = :git
#   deploy.branch = 'master'
# end

activate :gemoji, size: 20

activate :external_pipeline,
  name: :webpack,
  command: build? ? 'npm run build' : 'npm run start',
  source: '.tmp/dist',
  latency: 1

# activate :imageoptim do |image_optim|
#   image_optim.pngout = false # Should disable pngout
#   image_optim.manifest = false
# end

# activate :search_engine_sitemap

activate :syntax

###
# Helpers
###
helpers do
  def root_url
    config[:protocol] + config[:host]
  end

  def root_url_with_port
    [root_url, optional_port].compact.join(':')
  end

  def host_with_port
    [config[:host], optional_port].compact.join(':')
  end

  def optional_port
    config[:port] unless config[:port].to_i == 80
  end

  def image_url(source)
    config[:protocol] + host_with_port + image_path(source)
  end
end

configure :development do
  # Reload the browser automatically whenever files change
  activate :livereload, host: '127.0.0.1'

  begin
    set :host, '0.0.0.0'
    set :port, 4567

    # activate :disqus do |d|
    #   # using a special shortname
    #   d.shortname = 'btlocal'
    #   d.root_url = root_url_with_port
    # end
    # Used for generating absolute URLs
  rescue NameError
    # Whoops.
  end
end

# Build-specific configuration
configure :build do
  activate :gzip

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, '/Content/images/'
  # activate :disqus do |d|
  #   # using a special shortname
  #   d.shortname = 'blaketidwell'
  #   d.root_url = root_url_with_port
  # end
end
