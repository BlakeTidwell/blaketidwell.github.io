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

# Per-page layout changes:
page '/feed.xml', layout: false

# Plugins
# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

activate :gemoji, size: 20
activate :search_engine_sitemap
activate :syntax

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = 'articles'

  blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  blog.layout = 'article'
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  blog.default_extension = ".md"

  blog.tag_template = 'tag.html'
  blog.calendar_template = 'calendar.html'

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

activate :external_pipeline,
  name: :webpack,
  command: build? ? 'npm run build' : 'npm run start',
  source: '.tmp/dist',
  latency: 1

activate :imageoptim do |image_optim|
  image_optim.pngout = false # Should disable pngout
  image_optim.manifest = false
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.deploy_method = :git
  deploy.branch = 'master'
end

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
    config[:host] = '0.0.0.0'
    config[:port] = 4567

    # activate :disqus do |d|
    #   # using a special shortname
    #   d.shortname = 'btlocal'
    #   d.root_url = root_url_with_port
    # end
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

  # activate :disqus do |d|
  #   # using a special shortname
  #   d.shortname = 'blaketidwell'
  #   d.root_url = root_url_with_port
  # end
end
