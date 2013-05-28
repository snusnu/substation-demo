$LOAD_PATH.unshift(File.expand_path('../app', __FILE__))

require 'demo/web/routes'

run Demo::Web::App
